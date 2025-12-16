import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_variant_model.freezed.dart';
part 'product_variant_model.g.dart';

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
class ProductVariantModel with _$ProductVariantModel {
  const ProductVariantModel._();

  const factory ProductVariantModel({
    required String id,
    required String productId,
    required String sku,

    // Variant Attributes
    required String size,
    String? sizeLabel,
    required String color,
    required String colorHex,
    String? colorFamily,

    // Pricing (if variant has different price)
    double? price,
    double? compareAtPrice,

    // Inventory
    @Default(0) int stock,
    @Default(0) int reservedStock,
    @Default(0) int availableStock,
    @Default(false) bool inStock,
    String? warehouseLocation,

    // Media
    @Default(<String>[]) List<String> imageUrls,

    // Barcode
    String? barcode,
    String? ean,
    String? upc,

    // Status
    @Default(true) bool isActive,
    @Default(false) bool isDeleted,

    // Timestamps
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _ProductVariantModel;

  factory ProductVariantModel.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantModelFromJson(json);

  factory ProductVariantModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) throw Exception('Variant document is null');

    return ProductVariantModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');

    json['createdAt'] ??= FieldValue.serverTimestamp();
    json['updatedAt'] ??= FieldValue.serverTimestamp();

    return json;
  }

  String get displayName => '$color - $size';
  bool get isAvailable => isActive && inStock && !isDeleted;
}