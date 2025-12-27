import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'reserved_item.dart';

part 'stock_reservation.freezed.dart';
part 'stock_reservation.g.dart';

/// ONE reservation per order (NON-NEGOTIABLE)
@freezed
class StockReservation with _$StockReservation {
  const StockReservation._();

  const factory StockReservation({
    /// Firestore document ID
    required String id,

    /// Ownership
    required String orderId,
    required String userId,

    /// All reserved items (atomic unit)
    required List<ReservedItem> items,

    /// active | committed | released | expired
    @Default('active') String status,

    /// Hard TTL – must be enforced by backend cleanup
    required DateTime expiresAt,

    /// Audit
    required DateTime createdAt,
  }) = _StockReservation;

  /// JSON (for Firestore)
  factory StockReservation.fromJson(Map<String, dynamic> json) =>
      _$StockReservationFromJson(json);

  /// Firestore document → model
  factory StockReservation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw StateError('StockReservation document is null');
    }

    return StockReservation.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  /// ---- DERIVED HELPERS (SAFE & USEFUL) ----

  bool get isActive => status == 'active';
  bool get isCommitted => status == 'committed';
  bool get isReleased => status == 'released';
  bool get isExpired => status == 'expired';

  bool get isTerminal =>
      status == 'committed' || status == 'released' || status == 'expired';
}
