import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

/// =======================================================
/// DTO — RESERVED STOCK ITEM (CALLABLE PAYLOAD)
/// =======================================================

@immutable
class ReservedStockItem {
  final String productId;
  final int quantity;

  const ReservedStockItem({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };
}

/// =======================================================
/// STOCK SERVICE (CLOUD FUNCTION ONLY)
/// =======================================================
///
/// RULES:
/// - Client NEVER touches Firestore
/// - Client NEVER commits or releases stock
/// - ALL stock mutation is server-authoritative
/// =======================================================

class StockFirestoreService {
  static const String _reserveFunctionName = 'reserveStock';

  final FirebaseFunctions _functions;

  /// Prevent duplicate in-flight calls per order
  Future<List<String>>? _inFlightReservation;

  StockFirestoreService({
    FirebaseFunctions? functions,
  }) : _functions =
            functions ?? FirebaseFunctions.instanceFor(region: 'us-central1');

  /// ---------------------------------------------------
  /// RESERVE STOCK (SAFE + IDEMPOTENT AT CLIENT LEVEL)
  /// ---------------------------------------------------
  Future<List<String>> reserveStockForOrder({
    required String orderId,
    required List<ReservedStockItem> items,
  }) {
    if (_inFlightReservation != null) {
      return _inFlightReservation!;
    }

    _inFlightReservation =
        _reserveStockInternal(orderId: orderId, items: items);

    return _inFlightReservation!;
  }

  Future<List<String>> _reserveStockInternal({
    required String orderId,
    required List<ReservedStockItem> items,
  }) async {
    if (items.isEmpty) {
      throw ArgumentError('Cannot reserve stock for empty item list');
    }

    debugPrint('🟢 reserveStock callable');
    debugPrint('   ↳ orderId=$orderId');
    debugPrint('   ↳ items=${items.length}');

    final callable = _functions.httpsCallable(
      _reserveFunctionName,
      options: HttpsCallableOptions(
        timeout: const Duration(seconds: 15),
      ),
    );

    try {
      final result = await callable.call(<String, dynamic>{
        'orderId': orderId,
        'items': items.map((e) => e.toJson()).toList(),
      });

      final data = result.data;

      if (data is! Map || data['reservationIds'] is! List) {
        throw StateError('Malformed response from $_reserveFunctionName');
      }

      final reservationIds = List<String>.from(data['reservationIds']);

      if (reservationIds.isEmpty) {
        throw StateError('No reservations returned from backend');
      }

      if (reservationIds.length != items.length) {
        throw StateError(
          'Reservation count mismatch: expected ${items.length}, got ${reservationIds.length}',
        );
      }

      debugPrint(
        '✅ Stock reserved (${reservationIds.length} reservations)',
      );

      return reservationIds;
    } on FirebaseFunctionsException catch (e) {
      debugPrint(
        '🔴 reserveStock failed [${e.code}] → ${e.message}',
      );
      rethrow;
    } catch (e) {
      debugPrint('🔴 reserveStock unknown error → $e');
      rethrow;
    } finally {
      _inFlightReservation = null;
    }
  }
}
