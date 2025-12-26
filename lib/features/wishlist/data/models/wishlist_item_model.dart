import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'wishlist_item_model.freezed.dart';
part 'wishlist_item_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is DateTime) return json;
    throw Exception('Invalid timestamp value: $json');
  }

  @override
  Object? toJson(DateTime? date) {
    if (date == null) return null;
    return Timestamp.fromDate(date);
  }
}

@freezed
class WishlistItemModel with _$WishlistItemModel {
  const WishlistItemModel._();

  const factory WishlistItemModel({
    required String id,
    required String userId,
    required String productId,
    required String productName,
    required String productSlug,
    required String brandName,
    required String thumbnailUrl,
    required double price,
    double? compareAtPrice,

    /// Soft availability hint (NOT authoritative)
    required bool inStock,
    @TimestampConverter() DateTime? addedAt,
  }) = _WishlistItemModel;

  factory WishlistItemModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemModelFromJson(json);

  factory WishlistItemModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Wishlist item document is null');
    }

    return WishlistItemModel.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');

    json['addedAt'] ??= FieldValue.serverTimestamp();
    return json;
  }

  bool get hasDiscount => compareAtPrice != null && compareAtPrice! > price;
}
