import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart'; // 🔥 REQUIRED
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

// Reuse TimestampConverter from user_model.dart
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
class ProductImage with _$ProductImage {
  const factory ProductImage({
    required String url,
    required String thumbnailUrl,
    required int sortOrder,
    String? altText,
    @Default(false) bool isPrimary,
  }) = _ProductImage;

  factory ProductImage.fromJson(Map<String, dynamic> json) =>
      _$ProductImageFromJson(json);
}

@freezed
class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    required String id,
    required String sku,
    required String name,
    required String slug,
    required String description,
    String? shortDescription,

    // Categorization
    required String brandId,
    required String brandName,
    required String categoryId,
    required String categoryName,
    @Default(<String>[]) List<String> categoryPath,
    String? subCategoryId,
    @Default(<String>[]) List<String> tags,

    // Pricing
    required double basePrice,
    required double sellingPrice,
    double? compareAtPrice,
    @Default(0) int discountPercentage,
    @Default('USD') String currency,
    double? costPrice,

    // Inventory Summary
    @Default(0) int totalStock,
    @Default(0) int reservedStock,
    @Default(0) int availableStock,
    @Default(false) bool inStock,
    @Default('out_of_stock') String stockStatus,
    @Default(10) int lowStockThreshold,

    // Media
    @Default(<ProductImage>[]) List<ProductImage> images,
    required String thumbnailUrl,
    String? videoUrl,
    String? video360Url,

    // Product Details
    @Default('') String material,
    @Default('') String careInstructions,
    @Default('regular') String fit,
    @Default('') String origin,
    @Default(<String, String>{}) Map<String, String> specifications,

    // SEO & Search
    @Default('') String metaTitle,
    @Default('') String metaDescription,
    @Default(<String>[]) List<String> searchKeywords,

    // Status & Flags
    @Default('draft') String status,
    @Default(false) bool isFeatured,
    @Default(false) bool isNewArrival,
    @Default(false) bool isBestseller,
    @Default(false) bool isSale,
    @Default(false) bool isExclusive,

    // Ratings & Reviews
    @Default(0.0) double averageRating,
    @Default(0) int totalReviews,
    @Default(<int, int>{}) Map<int, int> ratingDistribution,

    // Analytics
    @Default(0) int viewCount,
    @Default(0) int addToCartCount,
    @Default(0) int purchaseCount,
    @Default(0) int wishlistCount,
    @Default(0.0) double conversionRate,
    @Default(0.0) double popularityScore,

    // Vendor Info
    String? vendorId,
    String? vendorName,

    // Shipping
    double? weight,
    @Default(<String, double>{}) Map<String, double> dimensions,
    @Default(false) bool freeShipping,
    @Default(<String>[]) List<String> shippingMethods,

    // Timestamps - ALL NULLABLE with TimestampConverter
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? publishedAt,
    @TimestampConverter() DateTime? deletedAt,

    // Metadata
    String? createdBy,
    String? updatedBy,
    @Default(false) bool isDeleted,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  factory ProductModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    if (data == null) throw Exception('Product document is null');

    return ProductModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');

    json['createdAt'] ??= FieldValue.serverTimestamp();
    json['updatedAt'] ??= FieldValue.serverTimestamp();

    return json;
  }

  // Computed properties
  bool get hasDiscount => (compareAtPrice ?? 0) > sellingPrice;
  bool get isLowStock => availableStock > 0 && availableStock <= lowStockThreshold;
  bool get isAvailable => status == 'active' && inStock && !isDeleted;
  String get displayPrice => '\$$sellingPrice';
  String get originalPrice => compareAtPrice != null ? '\$$compareAtPrice' : '';
// Computed properties

bool get isTrending =>
    popularityScore >= 0.7 ||
    viewCount >= 100 ||
    addToCartCount >= 50;
}