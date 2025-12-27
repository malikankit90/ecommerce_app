import {onCall, HttpsError} from "firebase-functions/v2/https";
import {initializeApp} from "firebase-admin/app";
import {getFirestore, FieldValue} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";

initializeApp();
const db = getFirestore();

/* ============================
   TYPES (INTERNAL ONLY)
   ============================ */

interface Reservation {
  productId: string;
  quantity: number;
  userId: string;
  status: "active" | "expired" | "committed";
}

interface Product {
  name: string;
  sellingPrice: number;
}

interface OrderItem {
  productId: string;
  name: string;
  price: number;
  quantity: number;
}

/* ============================
   HELPERS
   ============================ */

function generateOrderNumber(): string {
  const ts = Date.now().toString();
  return `ORD-${ts.substring(ts.length - 10)}`;
}

/* ============================
   FUNCTION
   ============================ */

export const createOrder = onCall(
  {region: "us-central1"},
  async (request) => {
    const uid = request.auth?.uid;

    const {
      idempotencyKey,
      reservationIds,
      shippingAddress,
      paymentMethod,
      customerNote,
    } = request.data as {
      idempotencyKey: string;
      reservationIds: string[];
      shippingAddress: Record<string, unknown>;
      paymentMethod: string;
      customerNote?: string;
    };

    /* ---------- AUTH ---------- */
    if (!uid) {
      throw new HttpsError("unauthenticated", "Login required");
    }

    /* ---------- VALIDATION ---------- */
    if (
      typeof idempotencyKey !== "string" ||
      !Array.isArray(reservationIds) ||
      reservationIds.length === 0 ||
      typeof shippingAddress !== "object" ||
      typeof paymentMethod !== "string"
    ) {
      throw new HttpsError("invalid-argument", "Invalid payload");
    }

    logger.info("CreateOrder started", {
      uid,
      idempotencyKey,
      reservationCount: reservationIds.length,
    });

    const orderId = await db.runTransaction(async (tx) => {
      /* ---------- IDEMPOTENCY (USER-SCOPED) ---------- */
      const existingSnap = await tx.get(
        db
          .collection("orders")
          .where("userId", "==", uid)
          .where("idempotencyKey", "==", idempotencyKey)
          .limit(1)
      );

      if (!existingSnap.empty) {
        const existingId = existingSnap.docs[0].id;
        logger.warn("Idempotent replay", {orderId: existingId});
        return existingId;
      }

      /* ---------- BUILD ORDER FROM RESERVATIONS ---------- */
      const items: OrderItem[] = [];
      let subtotal = 0;
      let totalItems = 0;

      for (const reservationId of reservationIds) {
        const resRef = db.collection("stock_reservations").doc(reservationId);
        const resSnap = await tx.get(resRef);

        if (!resSnap.exists) {
          throw new HttpsError(
            "failed-precondition",
            `Missing reservation ${reservationId}`
          );
        }

        const reservation = resSnap.data() as Reservation;

        // 🔍 HARD LOG — NEVER REMOVE
        logger.info("Reservation check", {
          reservationId,
          reservation,
        });

        if (
          reservation.status !== "active" ||
          reservation.userId !== uid ||
          reservation.quantity <= 0 ||
          typeof reservation.productId !== "string"
        ) {
          throw new HttpsError(
            "failed-precondition",
            `Invalid reservation ${reservationId}`
          );
        }

        const productRef = db
          .collection("products")
          .doc(reservation.productId);

        const productSnap = await tx.get(productRef);

        if (!productSnap.exists) {
          throw new HttpsError(
            "failed-precondition",
            `Product missing ${reservation.productId}`
          );
        }

        const product = productSnap.data() as Product;

        // 🔍 HARD LOG — NEVER REMOVE
        logger.info("Product check", {
          productId: reservation.productId,
          product,
        });

        if (
          typeof product.sellingPrice !== "number" ||
          product.sellingPrice <= 0 ||
          typeof product.name !== "string" ||
          product.name.length === 0
        ) {
          throw new HttpsError(
            "failed-precondition",
            `Corrupt product ${reservation.productId}`
          );
        }

        items.push({
          productId: reservation.productId,
          name: product.name,
          price: product.sellingPrice,
          quantity: reservation.quantity,
        });

        subtotal += product.sellingPrice * reservation.quantity;
        totalItems += reservation.quantity;
      }

      /* ---------- PRICING ---------- */
      const discount = 0;
      const shippingCost = 0;
      const tax = 0;
      const total = subtotal - discount + shippingCost + tax;

      const orderNumber = generateOrderNumber();

      /* ---------- CREATE ORDER ---------- */
      const orderRef = db.collection("orders").doc();

      tx.set(orderRef, {
        userId: uid,
        idempotencyKey,
        orderNumber,
        reservationIds,

        items,
        totalItems,

        subtotal,
        discount,
        shippingCost,
        tax,
        total,

        shippingAddress,
        paymentMethod,

        paymentStatus: "pending",
        status: "payment_pending",

        customerNote: customerNote ?? "",
        adminNote: "",
        isDeleted: false,

        createdAt: FieldValue.serverTimestamp(),
        updatedAt: FieldValue.serverTimestamp(),
        createdAtMillis: Date.now(),
      });

      logger.info("Order created", {
        orderId: orderRef.id,
        orderNumber,
      });

      return orderRef.id;
    });

    return {orderId};
  }
);
