import 'package:flutter/foundation.dart';

import '../models/order_model.dart';
import '../services/order_firestore_service.dart';

class OrderRepository {
  final OrderFirestoreService _firestoreService;

  OrderRepository({
    required OrderFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  // =====================================================
  // ORDERS — READ
  // =====================================================

  Stream<OrderModel?> getOrderStream(String orderId) {
    debugPrint('🟢 OrderRepository.getOrderStream → orderId=$orderId');
    return _firestoreService.getOrderStream(orderId);
  }

  Stream<List<OrderModel>> getUserOrdersStream(String userId) {
    debugPrint('🟢 OrderRepository.getUserOrdersStream → userId=$userId');
    return _firestoreService.getUserOrdersStream(userId);
  }

  // =====================================================
  // ORDERS — CREATE
  // =====================================================

  Future<String> createOrder(OrderModel order) async {
    debugPrint('🟢 OrderRepository.createOrder');
    debugPrint('   ↳ userId=${order.userId}');
    debugPrint('   ↳ idempotencyKey=${order.idempotencyKey}');
    debugPrint('   ↳ reservationIds=${order.reservationIds}');
    debugPrint('   ↳ orderNumber=${order.orderNumber}');

    final orderId = await _firestoreService.createOrder(order);

    debugPrint('✅ OrderRepository.createOrder → orderId=$orderId');
    return orderId;
  }

  // =====================================================
  // ORDERS — STATE UPDATES (SERVER / WEBHOOK)
  // =====================================================

  Future<void> updatePaymentSuccess(String orderId) async {
    debugPrint('🟢 OrderRepository.updatePaymentSuccess → $orderId');
    await _firestoreService.updatePaymentSuccess(orderId);
    debugPrint('✅ Payment marked SUCCESS → $orderId');
  }

  Future<void> updatePaymentFailure(String orderId) async {
    debugPrint('🟡 OrderRepository.updatePaymentFailure → $orderId');
    await _firestoreService.updatePaymentFailure(orderId);
    debugPrint('✅ Payment marked FAILED → $orderId');
  }

  // =====================================================
  // ORDERS — CANCEL
  // =====================================================

  Future<void> cancelOrder(String orderId) async {
    debugPrint('🟡 OrderRepository.cancelOrder → orderId=$orderId');
    await _firestoreService.cancelOrder(orderId);
    debugPrint('✅ OrderRepository.cancelOrder → success');
  }

  // =====================================================
  // UTIL
  // =====================================================

  Future<String> generateOrderNumber() async {
    final number = await _firestoreService.generateOrderNumber();
    debugPrint('🟢 OrderRepository.generateOrderNumber → $number');
    return number;
  }
}
