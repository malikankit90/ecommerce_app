import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

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
class CartItemModel with _$CartItemModel {
  const CartItemModel._();

  const factory CartItemModel({
    required String id,
    required String userId,

    // Product identity
    required String productId,
    required String productName,
    required String productSlug,
    required String brandName,
    required String thumbnailUrl,

    // Pricing
    required double price,
    double? compareAtPrice,
    required int quantity,

    // Variant info (if selected)
    String? variantId,
    String? size,
    String? color,
    String? colorHex,

    // Timestamps
    @TimestampConverter() DateTime? addedAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  factory CartItemModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Cart item document is null');
    }
    return CartItemModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');

    json['addedAt'] ??= FieldValue.serverTimestamp();
    json['updatedAt'] ??= FieldValue.serverTimestamp();

    return json;
  }

  // ============================
  // DERIVED UI HELPERS (SAFE)
  // ============================

  double get subtotal => price * quantity;

  double get savings =>
      compareAtPrice != null ? (compareAtPrice! - price) * quantity : 0.0;

  bool get hasDiscount => compareAtPrice != null && compareAtPrice! > price;

  String get variantDisplay =>
      size != null && color != null ? '$color - $size' : '';
}
