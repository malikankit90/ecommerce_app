import '../services/stock_firestore_service.dart';

class StockRepository {
  final StockFirestoreService _service;

  StockRepository({
    required StockFirestoreService service,
  }) : _service = service;

  /// ---------------------------------------------------
  /// Reserve stock for a SINGLE product
  /// Returns reservationId or null if insufficient stock
  /// ---------------------------------------------------
  Future<String?> reserve({
    required String productId,
    required int quantity,
    required String orderId,
  }) {
    return _service.reserveStock(
      productId: productId,
      quantity: quantity,
      orderId: orderId,
    );
  }

  /// ---------------------------------------------------
  /// Commit a reservation (payment success / COD)
  /// ---------------------------------------------------
  Future<void> commitReservation(String reservationId) {
    return _service.commitReservation(reservationId);
  }

  /// ---------------------------------------------------
  /// Release a reservation (failure / timeout / rollback)
  /// ---------------------------------------------------
  Future<void> releaseReservation(String reservationId) {
    return _service.releaseReservation(reservationId);
  }
}
