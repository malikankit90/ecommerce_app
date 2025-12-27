import 'package:flutter/foundation.dart';

import '../../../orders/data/repositories/order_repository.dart';
import '../../../orders/data/models/order_model.dart';
import '../../../stock/data/repositories/stock_repository.dart';

/// =======================================================
/// PAYMENT WEBHOOK HANDLER
/// Server-side ONLY
/// Idempotent by reservation status
/// =======================================================

class PaymentWebhookHandler {
  final OrderRepository _orderRepository;
  final StockRepository _stockRepository;

  PaymentWebhookHandler({
    required OrderRepository orderRepository,
    required StockRepository stockRepository,
  })  : _orderRepository = orderRepository,
        _stockRepository = stockRepository;

  /// ---------------------------------------------------
  /// PAYMENT SUCCESS
  /// ---------------------------------------------------
  Future<void> onPaymentSuccess({
    required String orderId,
  }) async {
    debugPrint('💰 Webhook: payment SUCCESS → orderId=$orderId');

    // 1️⃣ Load order
    final OrderModel? order =
        await _orderRepository.getOrderStream(orderId).first;

    if (order == null) {
      debugPrint('❌ Webhook: order not found → $orderId');
      return;
    }

    // 2️⃣ Guard: already paid / processed
    if (order.paymentStatus == 'paid') {
      debugPrint(
        '🟡 Webhook: order already paid → orderId=$orderId (noop)',
      );
      return;
    }

    // 3️⃣ Commit stock (idempotent)
    debugPrint(
      '🟢 Webhook: committing reservation → ${order.reservationId}',
    );
    await _stockRepository.commitReservation(order.reservationId);

    // 4️⃣ Update order payment state
    await _orderRepository.updatePaymentSuccess(orderId);

    debugPrint('✅ Webhook: payment success processed → $orderId');
  }

  /// ---------------------------------------------------
  /// PAYMENT FAILURE / TIMEOUT
  /// ---------------------------------------------------
  Future<void> onPaymentFailure({
    required String orderId,
  }) async {
    debugPrint('💥 Webhook: payment FAILED → orderId=$orderId');

    // 1️⃣ Load order
    final OrderModel? order =
        await _orderRepository.getOrderStream(orderId).first;

    if (order == null) {
      debugPrint('❌ Webhook: order not found → $orderId');
      return;
    }

    // 2️⃣ Guard: already final
    if (order.isFinal) {
      debugPrint(
        '🟡 Webhook: order already final → $orderId (noop)',
      );
      return;
    }

    // 3️⃣ Release stock (idempotent)
    debugPrint(
      '🟢 Webhook: releasing reservation → ${order.reservationId}',
    );
    await _stockRepository.releaseReservation(order.reservationId);

    // 4️⃣ Update order payment state
    await _orderRepository.updatePaymentFailure(orderId);

    debugPrint('✅ Webhook: payment failure processed → $orderId');
  }
}
