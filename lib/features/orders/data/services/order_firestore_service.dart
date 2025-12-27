import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';

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
  // READ — USER ORDERS (LIST) ✅ FINAL FIX
  // =====================================================
  Stream<List<OrderModel>> getUserOrdersStream(String userId) {
    return _orders
        .where('userId', isEqualTo: userId)
        .where('isDeleted', isEqualTo: false)
        // 🔥 ORDER BY DOCUMENT ID — WORKS IN ALL SDK VERSIONS
        .orderBy('__name__', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(OrderModel.fromFirestore).toList(),
        );
  }
}
