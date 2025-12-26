import '../../../stock/data/repositories/stock_repository.dart';

class PaymentWebhookHandler {
  final StockRepository _stockRepository;

  PaymentWebhookHandler(this._stockRepository);

  Future<void> onPaymentSuccess({
    required String orderId,
    required String reservationId,
  }) async {
    await _stockRepository.commit(
      reservationId: reservationId,
      orderId: orderId,
    );
  }

  Future<void> onPaymentFailure({
    required String reservationId,
  }) async {
    await _stockRepository.release(reservationId);
  }
}
