import '../models/order_model.dart';
import '../services/order_firestore_service.dart';

class OrderRepository {
  final OrderFirestoreService _firestoreService;

  OrderRepository({
    required OrderFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  // =====================================================
  // Orders - Read
  // =====================================================

  Future<OrderModel?> getOrderById(String orderId) async {
    try {
      return await _firestoreService.getOrderById(orderId);
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  Stream<OrderModel?> getOrderStream(String orderId) {
    try {
      return _firestoreService.getOrderStream(orderId);
    } catch (e) {
      throw Exception('Failed to stream order: $e');
    }
  }

  Stream<List<OrderModel>> getUserOrdersStream(String userId) {
    try {
      return _firestoreService.getUserOrdersStream(userId);
    } catch (e) {
      throw Exception('Failed to stream user orders: $e');
    }
  }

  Future<List<OrderModel>> getUserOrders(String userId) async {
    try {
      return await _firestoreService.getUserOrders(userId);
    } catch (e) {
      throw Exception('Failed to get user orders: $e');
    }
  }

  // =====================================================
  // Orders - Write
  // =====================================================

  Future<void> createOrder(OrderModel order) async {
    try {
      await _firestoreService.createOrder(order);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _firestoreService.updateOrderStatus(orderId, status);
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  Future<void> cancelOrder(String orderId) async {
    try {
      await _firestoreService.cancelOrder(orderId);
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }

  Future<String> generateOrderNumber() async {
    try {
      return await _firestoreService.generateOrderNumber();
    } catch (e) {
      throw Exception('Failed to generate order number: $e');
    }
  }
}