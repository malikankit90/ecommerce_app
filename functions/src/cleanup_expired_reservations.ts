import {onSchedule} from "firebase-functions/v2/scheduler";
import {initializeApp} from "firebase-admin/app";
import {getFirestore, Timestamp, FieldValue} from "firebase-admin/firestore";
import * as logger from "firebase-functions/logger";

initializeApp();
const db = getFirestore();

const BATCH_SIZE = 50;

export const cleanupExpiredReservations = onSchedule(
  {
    schedule: "every 5 minutes",
    timeZone: "UTC",
    region: "us-central1",
    memory: "256MiB",
    timeoutSeconds: 60,
  },
  async () => {
    logger.info("🧹 TTL cleanup started", {service: "stock"});

    const now = Timestamp.now();

    const snapshot = await db
      .collection("stock_reservations")
      .where("status", "==", "active")
      .where("expiresAt", "<=", now)
      .limit(BATCH_SIZE)
      .get();

    if (snapshot.empty) {
      logger.info("✅ No expired reservations found", {service: "stock"});
      return;
    }

    logger.warn("⚠️ Expired reservations found", {
      count: snapshot.size,
      service: "stock",
    });

    await Promise.all(
      snapshot.docs.map(async (doc) => {
        const reservationId = doc.id;

        try {
          await db.runTransaction(async (tx) => {
            const resRef = doc.ref;
            const resSnap = await tx.get(resRef);

            if (!resSnap.exists) return;

            const res = resSnap.data();
            if (!res) return;

            // 🔒 STRICT STATE GUARD
            if (res.status !== "active") return;

            const productId = res.productId;
            const quantity = res.quantity;

            if (
              typeof productId !== "string" ||
              typeof quantity !== "number" ||
              quantity <= 0
            ) {
              logger.error("❌ Invalid reservation payload", {
                reservationId,
                productId,
                quantity,
              });

              tx.update(resRef, {
                status: "invalid",
                updatedAt: FieldValue.serverTimestamp(),
              });
              return;
            }

            const productRef = db.collection("products").doc(productId);
            const productSnap = await tx.get(productRef);

            if (!productSnap.exists) {
              logger.warn("⚠️ Product missing during cleanup", {
                reservationId,
                productId,
              });

              tx.update(resRef, {
                status: "orphaned",
                updatedAt: FieldValue.serverTimestamp(),
              });
              return;
            }

            const product = productSnap.data()!;
            const reservedStock = product.reservedStock ?? 0;

            if (reservedStock < quantity) {
              logger.error("🚨 Stock corruption detected", {
                reservationId,
                productId,
                reservedStock,
                quantity,
              });

              tx.update(resRef, {
                status: "corrupt",
                updatedAt: FieldValue.serverTimestamp(),
              });
              return;
            }

            // ✅ RELEASE STOCK
            tx.update(productRef, {
              reservedStock: reservedStock - quantity,
              updatedAt: FieldValue.serverTimestamp(),
            });

            // ✅ FINALIZE RESERVATION
            tx.update(resRef, {
              status: "expired",
              releasedAt: FieldValue.serverTimestamp(),
            });
          });

          logger.info("✅ Reservation released", {
            reservationId,
            service: "stock",
          });
        } catch (err) {
          logger.error("❌ Failed releasing reservation", {
            reservationId,
            error: err,
          });
        }
      }),
    );

    logger.info("🏁 TTL cleanup finished", {service: "stock"});
  },
);
