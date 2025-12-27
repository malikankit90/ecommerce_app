import {onCall, HttpsError} from "firebase-functions/v2/https";
import {getFirestore, FieldValue, Timestamp} from "firebase-admin/firestore";
import {initializeApp} from "firebase-admin/app";

initializeApp();
const db = getFirestore();

const RESERVATION_TTL_MINUTES = 15;

export const reserveStock = onCall(async (request) => {
  const uid = request.auth?.uid;
  const {items, orderId} = request.data;

  // ================= AUTH =================
  if (!uid) {
    throw new HttpsError("unauthenticated", "User must be authenticated");
  }

  // ================= INPUT =================
  if (!orderId || typeof orderId !== "string") {
    throw new HttpsError("invalid-argument", "Invalid orderId");
  }

  if (!Array.isArray(items) || items.length === 0) {
    throw new HttpsError("invalid-argument", "Items must be a non-empty array");
  }

  // ================= HARD INVARIANTS =================
  const seenProducts = new Set<string>();
  for (const item of items) {
    if (
      !item ||
      typeof item.productId !== "string" ||
      typeof item.quantity !== "number" ||
      !Number.isInteger(item.quantity) ||
      item.quantity <= 0
    ) {
      throw new HttpsError(
        "invalid-argument",
        `Invalid item payload: ${JSON.stringify(item)}`,
      );
    }

    if (seenProducts.has(item.productId)) {
      throw new HttpsError(
        "invalid-argument",
        `Duplicate productId in order: ${item.productId}`,
      );
    }

    seenProducts.add(item.productId);
  }

  const expiresAt = Timestamp.fromDate(
    new Date(Date.now() + RESERVATION_TTL_MINUTES * 60 * 1000),
  );

  const reservationIds: string[] = [];

  await db.runTransaction(async (tx) => {
    for (const item of items) {
      const productRef = db.collection("products").doc(item.productId);
      const productSnap = await tx.get(productRef);

      if (!productSnap.exists) {
        throw new HttpsError(
          "not-found",
          `Product not found: ${item.productId}`,
        );
      }

      const product = productSnap.data()!;
      const totalStock = product.totalStock ?? 0;
      const reservedStock = product.reservedStock ?? 0;

      if (totalStock - reservedStock < item.quantity) {
        throw new HttpsError(
          "failed-precondition",
          `Insufficient stock for product ${item.productId}`,
        );
      }

      // 🔐 DETERMINISTIC ID (TRUE IDEMPOTENCY)
      const reservationId = `${orderId}_${item.productId}`;
      const reservationRef = db
        .collection("stock_reservations")
        .doc(reservationId);

      const existingSnap = await tx.get(reservationRef);
      if (existingSnap.exists) {
        reservationIds.push(reservationRef.id);
        continue;
      }

      // ---------- UPDATE PRODUCT ----------
      tx.update(productRef, {
        reservedStock: reservedStock + item.quantity,
        updatedAt: FieldValue.serverTimestamp(),
      });

      // ---------- CREATE RESERVATION ----------
      tx.set(reservationRef, {
        productId: item.productId,
        quantity: item.quantity,
        orderId,
        userId: uid,
        status: "active",
        createdAt: FieldValue.serverTimestamp(),
        expiresAt,
      });

      reservationIds.push(reservationRef.id);
    }
  });

  return {reservationIds};
});
