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
  // ORDERS — WRITE
  // =====================================================

  /// -----------------------------------------------------
  /// CREATE ORDER (IDEMPOTENT)
  ///
  /// IMPORTANT:
  /// - order.id IS the idempotency key
  /// - Safe to retry
  /// - May return EXISTING orderId
  /// -----------------------------------------------------
  Future<String> createOrder(OrderModel order) async {
    debugPrint('🟢 OrderRepository.createOrder');
    debugPrint('   ↳ userId=${order.userId}');
    debugPrint('   ↳ idempotencyKey(order.id)=${order.id}');
    debugPrint('   ↳ orderNumber=${order.orderNumber}');

    final orderId = await _firestoreService.createOrder(order);

    debugPrint('✅ OrderRepository.createOrder → orderId=$orderId');
    return orderId;
  }

  /// -----------------------------------------------------
  /// CANCEL ORDER
  /// (Firestore rules enforce safety)
  /// -----------------------------------------------------
  Future<void> cancelOrder(String orderId) async {
    debugPrint('🟡 OrderRepository.cancelOrder → orderId=$orderId');
    await _firestoreService.cancelOrder(orderId);
    debugPrint('✅ OrderRepository.cancelOrder → success');
  }

  /// -----------------------------------------------------
  /// GENERATE ORDER NUMBER
  /// -----------------------------------------------------
  Future<String> generateOrderNumber() async {
    final number = await _firestoreService.generateOrderNumber();
    debugPrint('🟢 OrderRepository.generateOrderNumber → $number');
    return number;
  }
}
