import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';

/// =====================================================
/// ORDER FIRESTORE SERVICE (READ-ONLY)
/// =====================================================
///
/// ❗ IMPORTANT ARCHITECTURAL GUARANTEE
/// ----------------------------------
/// This service:
/// - NEVER creates orders
/// - NEVER updates orders
/// - NEVER cancels orders
/// - NEVER touches payment state
///
/// All order mutations happen ONLY via Cloud Functions.
/// Flutter is a READ-ONLY consumer of /orders.
///
/// If you ever feel tempted to add a write here:
/// 👉 stop — you are breaking server authority.
/// =====================================================

class OrderFirestoreService {
  OrderFirestoreService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _orders =>
      _firestore.collection('orders');

  // =====================================================
  // READ — SINGLE ORDER
  // =====================================================
  Stream<OrderModel?> getOrderStream(String orderId) {
    return _orders.doc(orderId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return OrderModel.fromFirestore(doc);
    });
  }

  // =====================================================
  // READ — USER ORDERS (LIST)
  // =====================================================
  Stream<List<OrderModel>> getUserOrdersStream(String userId) {
    return _orders
        .where('userId', isEqualTo: userId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAtMillis', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(OrderModel.fromFirestore).toList(),
        );
  }
}
