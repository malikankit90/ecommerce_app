import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'stock_reservation.freezed.dart';
part 'stock_reservation.g.dart';

@freezed
class StockReservation with _$StockReservation {
  const factory StockReservation({
    required String id,
    required String productId,
    required int quantity,
    required String orderId,
    @Default('active') String status, // active | committed | released | expired

    DateTime? expiresAt,
    DateTime? createdAt,
  }) = _StockReservation;

  factory StockReservation.fromJson(Map<String, dynamic> json) =>
      _$StockReservationFromJson(json);

  factory StockReservation.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw Exception('StockReservation document is null');
    }

    return StockReservation.fromJson({
      ...data,
      'id': doc.id,
    });
  }
}
