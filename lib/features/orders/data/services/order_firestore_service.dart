import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/order_model.dart';

class OrderFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _orders =>
      _firestore.collection('orders');

  // =====================================================
  // CREATE — IDEMPOTENT (TRANSACTION SAFE)
  // OrderModel.id == IDEMPOTENCY KEY
  // =====================================================
  Future<String> createOrder(OrderModel order) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final idempotencyKey = order.id;

    debugPrint('🟢 Firestore.createOrder (IDEMPOTENT)');
    debugPrint('   ↳ userId=${user.uid}');
    debugPrint('   ↳ idempotencyKey=$idempotencyKey');
    debugPrint('   ↳ orderNumber=${order.orderNumber}');

    return await _firestore.runTransaction<String>((transaction) async {
      // -------------------------------------------------
      // 1️⃣ Check for existing order with same idempotencyKey
      // -------------------------------------------------
      final querySnapshot = await _orders
          .where('userId', isEqualTo: user.uid)
          .where('idempotencyKey', isEqualTo: idempotencyKey)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final existingDoc = querySnapshot.docs.first;
        debugPrint(
          '🟡 IDEMPOTENCY HIT → existing orderId=${existingDoc.id}',
        );
        return existingDoc.id;
      }

      // -------------------------------------------------
      // 2️⃣ Create new order (ONLY ONCE)
      // -------------------------------------------------
      final newDocRef = _orders.doc();

      transaction.set(newDocRef, {
        // ---------------- CORE ----------------
        'userId': user.uid,
        'idempotencyKey': idempotencyKey,
        'orderNumber': order.orderNumber,

        // ---------------- ITEMS ----------------
        'items': order.items.map((e) => e.toJson()).toList(),
        'totalItems': order.totalItems,

        // ---------------- PRICING ----------------
        'subtotal': order.subtotal,
        'discount': order.discount,
        'shippingCost': order.shippingCost,
        'tax': order.tax,
        'total': order.total,

        // ---------------- SHIPPING ----------------
        'shippingAddress': order.shippingAddress.toJson(),

        // ---------------- PAYMENT ----------------
        'paymentMethod': order.paymentMethod,
        'paymentStatus': 'pending',

        // ---------------- ORDER STATE ----------------
        'status': 'payment_pending',

        // ---------------- META ----------------
        'customerNote': order.customerNote ?? '',
        'isDeleted': false,

        // ---------------- TIMESTAMPS ----------------
        'createdAt': FieldValue.serverTimestamp(),
        'createdAtMillis': DateTime.now().millisecondsSinceEpoch,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      debugPrint(
        '✅ Firestore.createOrder SUCCESS → orderId=${newDocRef.id}',
      );
      return newDocRef.id;
    });
  }

  // =====================================================
  // READ
  // =====================================================
  Stream<OrderModel?> getOrderStream(String orderId) {
    debugPrint('🟢 Firestore.getOrderStream → $orderId');

    return _orders.doc(orderId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return OrderModel.fromFirestore(doc);
    });
  }

  Stream<List<OrderModel>> getUserOrdersStream(String userId) {
    debugPrint('🟢 Firestore.getUserOrdersStream → userId=$userId');

    return _orders
        .where('userId', isEqualTo: userId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAtMillis', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(OrderModel.fromFirestore).toList(),
        );
  }

  // =====================================================
  // CANCEL (CLIENT-ALLOWED BEFORE SHIPPED)
  // =====================================================
  Future<void> cancelOrder(String orderId) async {
    debugPrint('🟡 Firestore.cancelOrder → $orderId');

    await _orders.doc(orderId).update({
      'status': 'cancelled',
      'updatedAt': FieldValue.serverTimestamp(),
    });

    debugPrint('✅ Firestore.cancelOrder SUCCESS → $orderId');
  }

  // =====================================================
  // UTIL
  // =====================================================
  Future<String> generateOrderNumber() async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return 'ORD-${ts.toString().substring(ts.toString().length - 10)}';
  }
}
