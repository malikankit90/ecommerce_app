import {onRequest} from "firebase-functions/v2/https";
import {initializeApp} from "firebase-admin/app";
import {getFirestore, FieldValue} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";
import * as crypto from "crypto";

initializeApp();
const db = getFirestore();

/**
 * =====================================================
 * PAYMENT SUCCESS WEBHOOK (SERVER ONLY)
 * =====================================================
 *
 * - Triggered by payment gateway (NOT Flutter)
 * - Verifies signature
 * - Commits stock reservations
 * - Marks order paid
 * - Idempotent & transaction-safe
 */

// 🔐 Replace with your gateway secret
const PAYMENT_WEBHOOK_SECRET = process.env.PAYMENT_WEBHOOK_SECRET!;

export const handlePaymentSuccess = onRequest(
  {
    region: "us-central1",
    timeoutSeconds: 60,
  },
  async (req, res) => {
    try {
      // -------------------------------------------------
      // 1️⃣ VERIFY HTTP METHOD
      // -------------------------------------------------
      if (req.method !== "POST") {
        res.status(405).send("Method Not Allowed");
        return;
      }

      // -------------------------------------------------
      // 2️⃣ VERIFY PAYMENT SIGNATURE
      // -------------------------------------------------
      const signature = req.headers["x-payment-signature"];
      if (!signature || typeof signature !== "string") {
        res.status(401).send("Missing signature");
        return;
      }

      const rawBody = JSON.stringify(req.body);
      const expectedSignature = crypto
        .createHmac("sha256", PAYMENT_WEBHOOK_SECRET)
        .update(rawBody)
        .digest("hex");

      if (signature !== expectedSignature) {
        logger.error("Invalid payment signature");
        res.status(401).send("Invalid signature");
        return;
      }

      // -------------------------------------------------
      // 3️⃣ PARSE PAYLOAD
      // -------------------------------------------------
      const {orderId, paymentId} = req.body;

      if (!orderId || typeof orderId !== "string") {
        res.status(400).send("Invalid orderId");
        return;
      }

      logger.info("Payment webhook received", {orderId, paymentId});

      // -------------------------------------------------
      // 4️⃣ TRANSACTION (IDEMPOTENT)
      // -------------------------------------------------
      await db.runTransaction(async (tx) => {
        const orderRef = db.collection("orders").doc(orderId);
        const orderSnap = await tx.get(orderRef);

        if (!orderSnap.exists) {
          throw new Error("Order not found");
        }

        const order = orderSnap.data()!;

        // 🔁 IDEMPOTENCY
        if (order.paymentStatus === "paid") {
          logger.warn("Payment already processed", {orderId});
          return;
        }

        if (order.status !== "payment_pending") {
          throw new Error(`Invalid order state: ${order.status}`);
        }

        const reservationIds: string[] = order.reservationIds;
        if (!Array.isArray(reservationIds) || reservationIds.length === 0) {
          throw new Error("Order has no reservations");
        }

        // -------------------------------------------------
        // 5️⃣ COMMIT EACH RESERVATION
        // -------------------------------------------------
        for (const reservationId of reservationIds) {
          const resRef = db.collection("stock_reservations").doc(reservationId);

          const resSnap = await tx.get(resRef);
          if (!resSnap.exists) {
            throw new Error(`Reservation missing: ${reservationId}`);
          }

          const res = resSnap.data()!;
          if (res.status !== "active") {
            throw new Error(
              `Reservation ${reservationId} not active (${res.status})`,
            );
          }

          const productRef = db.collection("products").doc(res.productId);
          const productSnap = await tx.get(productRef);

          if (!productSnap.exists) {
            throw new Error(`Product missing: ${res.productId}`);
          }

          const product = productSnap.data()!;
          const totalStock = product.totalStock ?? 0;
          const reservedStock = product.reservedStock ?? 0;

          if (totalStock < res.quantity || reservedStock < res.quantity) {
            throw new Error(`Stock corruption for product ${res.productId}`);
          }

          // 🔽 APPLY STOCK
          tx.update(productRef, {
            totalStock: totalStock - res.quantity,
            reservedStock: reservedStock - res.quantity,
            updatedAt: FieldValue.serverTimestamp(),
          });

          // 🔒 COMMIT RESERVATION
          tx.update(resRef, {
            status: "committed",
            committedAt: FieldValue.serverTimestamp(),
          });
        }

        // -------------------------------------------------
        // 6️⃣ UPDATE ORDER
        // -------------------------------------------------
        tx.update(orderRef, {
          paymentStatus: "paid",
          status: "confirmed",
          paymentId,
          paidAt: FieldValue.serverTimestamp(),
          updatedAt: FieldValue.serverTimestamp(),
        });
      });

      logger.info("Payment committed successfully", {orderId});
      res.status(200).json({success: true});
    } catch (err) {
      logger.error("Payment commit failed", err);
      res.status(500).send("Internal Server Error");
    }
  },
);
