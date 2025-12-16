import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class OrderFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _orders =>
      _firestore.collection('orders');

  // =====================================================
  // CREATE
  // =====================================================

  Future<void> createOrder(OrderModel order) async {
    final nowMillis = DateTime.now().millisecondsSinceEpoch;

    await _orders.doc(order.id).set({
      'userId': order.userId,
      'orderNumber': order.orderNumber,

      // Items
      'items': order.items.map((e) => e.toJson()).toList(),
      'totalItems': order.totalItems,

      // Pricing
      'subtotal': order.subtotal,
      'discount': order.discount,
      'shippingCost': order.shippingCost,
      'tax': order.tax,
      'total': order.total,

      // Shipping
      'shippingAddress': order.shippingAddress.toJson(),

      // Payment
      'paymentMethod': order.paymentMethod,
      'paymentStatus': order.paymentStatus,

      // Status
      'status': order.status,

      // Tracking
      'trackingNumber': order.trackingNumber,
      'carrier': order.carrier,

      // Notes
      'customerNote': order.customerNote,
      'adminNote': order.adminNote,

      'isDeleted': false,

      // 🔥 AUTHORITATIVE TIMESTAMPS
      'createdAt': FieldValue.serverTimestamp(),
      'createdAtMillis': nowMillis,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // =====================================================
  // READ
  // =====================================================

  Future<OrderModel?> getOrderById(String orderId) async {
    final doc = await _orders.doc(orderId).get();
    if (!doc.exists || doc.data() == null) return null;
    return OrderModel.fromFirestore(doc);
  }

  Stream<OrderModel?> getOrderStream(String orderId) {
    return _orders.doc(orderId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return OrderModel.fromFirestore(doc);
    });
  }

  Stream<List<OrderModel>> getUserOrdersStream(String userId) {
    return _orders
        .where('userId', isEqualTo: userId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAtMillis', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map(OrderModel.fromFirestore).toList(),
        );
  }

  Future<List<OrderModel>> getUserOrders(String userId) async {
    final snapshot = await _orders
        .where('userId', isEqualTo: userId)
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAtMillis', descending: true)
        .get();

    return snapshot.docs.map(OrderModel.fromFirestore).toList();
  }

  // =====================================================
  // UPDATE
  // =====================================================

  Future<void> updateOrderStatus(String orderId, String status) async {
    final updates = <String, dynamic>{
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (status == 'confirmed') {
      updates['confirmedAt'] = FieldValue.serverTimestamp();
    } else if (status == 'shipped') {
      updates['shippedAt'] = FieldValue.serverTimestamp();
    } else if (status == 'delivered') {
      updates['deliveredAt'] = FieldValue.serverTimestamp();
    } else if (status == 'cancelled') {
      updates['cancelledAt'] = FieldValue.serverTimestamp();
    }

    await _orders.doc(orderId).update(updates);
  }

  Future<void> updateTrackingInfo(
    String orderId,
    String trackingNumber,
    String carrier,
  ) async {
    await _orders.doc(orderId).update({
      'trackingNumber': trackingNumber,
      'carrier': carrier,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> cancelOrder(String orderId) async {
    await updateOrderStatus(orderId, 'cancelled');
  }

  // =====================================================
  // UTIL
  // =====================================================

  Future<String> generateOrderNumber() async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    return 'ORD-${ts.toString().substring(ts.toString().length - 10)}';
  }
}
