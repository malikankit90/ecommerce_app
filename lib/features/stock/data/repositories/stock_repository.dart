import '../services/stock_firestore_service.dart';

/// =======================================================
/// STOCK REPOSITORY
/// =======================================================
///
/// ROLE:
/// - Thin abstraction over StockFirestoreService
/// - No serialization
/// - No Firestore logic
/// - No business rules
/// =======================================================

class StockRepository {
  final StockFirestoreService _service;

  StockRepository({
    required StockFirestoreService service,
  }) : _service = service;

  /// ---------------------------------------------------
  /// RESERVE STOCK (ORDER-LEVEL)
  ///
  /// - Delegates to Cloud Function
  /// - Returns reservationIds
  /// - Client NEVER commits or releases stock
  /// ---------------------------------------------------
  Future<List<String>> reserveStockForOrder({
    required String orderId,
    required List<ReservedStockItem> items,
  }) {
    return _service.reserveStockForOrder(
      orderId: orderId,
      items: items,
    );
  }
}
