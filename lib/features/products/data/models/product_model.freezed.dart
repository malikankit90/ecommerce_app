// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) {
  return _ProductImage.fromJson(json);
}

/// @nodoc
mixin _$ProductImage {
  String get url => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  String? get altText => throw _privateConstructorUsedError;
  bool get isPrimary => throw _privateConstructorUsedError;

  /// Serializes this ProductImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductImageCopyWith<ProductImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductImageCopyWith<$Res> {
  factory $ProductImageCopyWith(
          ProductImage value, $Res Function(ProductImage) then) =
      _$ProductImageCopyWithImpl<$Res, ProductImage>;
  @useResult
  $Res call(
      {String url,
      String thumbnailUrl,
      int sortOrder,
      String? altText,
      bool isPrimary});
}

/// @nodoc
class _$ProductImageCopyWithImpl<$Res, $Val extends ProductImage>
    implements $ProductImageCopyWith<$Res> {
  _$ProductImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? thumbnailUrl = null,
    Object? sortOrder = null,
    Object? altText = freezed,
    Object? isPrimary = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      altText: freezed == altText
          ? _value.altText
          : altText // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductImageImplCopyWith<$Res>
    implements $ProductImageCopyWith<$Res> {
  factory _$$ProductImageImplCopyWith(
          _$ProductImageImpl value, $Res Function(_$ProductImageImpl) then) =
      __$$ProductImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String thumbnailUrl,
      int sortOrder,
      String? altText,
      bool isPrimary});
}

/// @nodoc
class __$$ProductImageImplCopyWithImpl<$Res>
    extends _$ProductImageCopyWithImpl<$Res, _$ProductImageImpl>
    implements _$$ProductImageImplCopyWith<$Res> {
  __$$ProductImageImplCopyWithImpl(
      _$ProductImageImpl _value, $Res Function(_$ProductImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? thumbnailUrl = null,
    Object? sortOrder = null,
    Object? altText = freezed,
    Object? isPrimary = null,
  }) {
    return _then(_$ProductImageImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: null == sortOrder
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int,
      altText: freezed == altText
          ? _value.altText
          : altText // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrimary: null == isPrimary
          ? _value.isPrimary
          : isPrimary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImageImpl implements _ProductImage {
  const _$ProductImageImpl(
      {required this.url,
      required this.thumbnailUrl,
      required this.sortOrder,
      this.altText,
      this.isPrimary = false});

  factory _$ProductImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImageImplFromJson(json);

  @override
  final String url;
  @override
  final String thumbnailUrl;
  @override
  final int sortOrder;
  @override
  final String? altText;
  @override
  @JsonKey()
  final bool isPrimary;

  @override
  String toString() {
    return 'ProductImage(url: $url, thumbnailUrl: $thumbnailUrl, sortOrder: $sortOrder, altText: $altText, isPrimary: $isPrimary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImageImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.altText, altText) || other.altText == altText) &&
            (identical(other.isPrimary, isPrimary) ||
                other.isPrimary == isPrimary));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, thumbnailUrl, sortOrder, altText, isPrimary);

  /// Create a copy of ProductImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImageImplCopyWith<_$ProductImageImpl> get copyWith =>
      __$$ProductImageImplCopyWithImpl<_$ProductImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImageImplToJson(
      this,
    );
  }
}

abstract class _ProductImage implements ProductImage {
  const factory _ProductImage(
      {required final String url,
      required final String thumbnailUrl,
      required final int sortOrder,
      final String? altText,
      final bool isPrimary}) = _$ProductImageImpl;

  factory _ProductImage.fromJson(Map<String, dynamic> json) =
      _$ProductImageImpl.fromJson;

  @override
  String get url;
  @override
  String get thumbnailUrl;
  @override
  int get sortOrder;
  @override
  String? get altText;
  @override
  bool get isPrimary;

  /// Create a copy of ProductImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductImageImplCopyWith<_$ProductImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductModel {
  String get id => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get slug => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get shortDescription =>
      throw _privateConstructorUsedError; // Categorization
  String get brandId => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  List<String> get categoryPath => throw _privateConstructorUsedError;
  String? get subCategoryId => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError; // Pricing
  double get basePrice => throw _privateConstructorUsedError;
  double get sellingPrice => throw _privateConstructorUsedError;
  double? get compareAtPrice => throw _privateConstructorUsedError;
  int get discountPercentage => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  double? get costPrice =>
      throw _privateConstructorUsedError; // 🔴 INVENTORY (SOURCE OF TRUTH ONLY)
  int get totalStock => throw _privateConstructorUsedError;
  int get reservedStock => throw _privateConstructorUsedError;
  int get lowStockThreshold => throw _privateConstructorUsedError; // Media
  List<ProductImage> get images => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  String? get video360Url =>
      throw _privateConstructorUsedError; // Product Details
  String get material => throw _privateConstructorUsedError;
  String get careInstructions => throw _privateConstructorUsedError;
  String get fit => throw _privateConstructorUsedError;
  String get origin => throw _privateConstructorUsedError;
  Map<String, String> get specifications =>
      throw _privateConstructorUsedError; // SEO & Search
  String get metaTitle => throw _privateConstructorUsedError;
  String get metaDescription => throw _privateConstructorUsedError;
  List<String> get searchKeywords =>
      throw _privateConstructorUsedError; // Status & Flags
  String get status => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  bool get isNewArrival => throw _privateConstructorUsedError;
  bool get isBestseller => throw _privateConstructorUsedError;
  bool get isSale => throw _privateConstructorUsedError;
  bool get isExclusive =>
      throw _privateConstructorUsedError; // Ratings & Reviews
  double get averageRating => throw _privateConstructorUsedError;
  int get totalReviews => throw _privateConstructorUsedError;
  Map<int, int> get ratingDistribution =>
      throw _privateConstructorUsedError; // Analytics
  int get viewCount => throw _privateConstructorUsedError;
  int get addToCartCount => throw _privateConstructorUsedError;
  int get purchaseCount => throw _privateConstructorUsedError;
  int get wishlistCount => throw _privateConstructorUsedError;
  double get conversionRate => throw _privateConstructorUsedError;
  double get popularityScore =>
      throw _privateConstructorUsedError; // Vendor Info
  String? get vendorId => throw _privateConstructorUsedError;
  String? get vendorName => throw _privateConstructorUsedError; // Shipping
  double? get weight => throw _privateConstructorUsedError;
  Map<String, double> get dimensions => throw _privateConstructorUsedError;
  bool get freeShipping => throw _privateConstructorUsedError;
  List<String> get shippingMethods =>
      throw _privateConstructorUsedError; // Timestamps
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError; // Metadata
  String? get createdBy => throw _privateConstructorUsedError;
  String? get updatedBy => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductModelCopyWith<ProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductModelCopyWith<$Res> {
  factory $ProductModelCopyWith(
          ProductModel value, $Res Function(ProductModel) then) =
      _$ProductModelCopyWithImpl<$Res, ProductModel>;
  @useResult
  $Res call(
      {String id,
      String sku,
      String name,
      String slug,
      String description,
      String? shortDescription,
      String brandId,
      String brandName,
      String categoryId,
      String categoryName,
      List<String> categoryPath,
      String? subCategoryId,
      List<String> tags,
      double basePrice,
      double sellingPrice,
      double? compareAtPrice,
      int discountPercentage,
      String currency,
      double? costPrice,
      int totalStock,
      int reservedStock,
      int lowStockThreshold,
      List<ProductImage> images,
      String thumbnailUrl,
      String? videoUrl,
      String? video360Url,
      String material,
      String careInstructions,
      String fit,
      String origin,
      Map<String, String> specifications,
      String metaTitle,
      String metaDescription,
      List<String> searchKeywords,
      String status,
      bool isFeatured,
      bool isNewArrival,
      bool isBestseller,
      bool isSale,
      bool isExclusive,
      double averageRating,
      int totalReviews,
      Map<int, int> ratingDistribution,
      int viewCount,
      int addToCartCount,
      int purchaseCount,
      int wishlistCount,
      double conversionRate,
      double popularityScore,
      String? vendorId,
      String? vendorName,
      double? weight,
      Map<String, double> dimensions,
      bool freeShipping,
      List<String> shippingMethods,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      @TimestampConverter() DateTime? publishedAt,
      @TimestampConverter() DateTime? deletedAt,
      String? createdBy,
      String? updatedBy,
      bool isDeleted});
}

/// @nodoc
class _$ProductModelCopyWithImpl<$Res, $Val extends ProductModel>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? name = null,
    Object? slug = null,
    Object? description = null,
    Object? shortDescription = freezed,
    Object? brandId = null,
    Object? brandName = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryPath = null,
    Object? subCategoryId = freezed,
    Object? tags = null,
    Object? basePrice = null,
    Object? sellingPrice = null,
    Object? compareAtPrice = freezed,
    Object? discountPercentage = null,
    Object? currency = null,
    Object? costPrice = freezed,
    Object? totalStock = null,
    Object? reservedStock = null,
    Object? lowStockThreshold = null,
    Object? images = null,
    Object? thumbnailUrl = null,
    Object? videoUrl = freezed,
    Object? video360Url = freezed,
    Object? material = null,
    Object? careInstructions = null,
    Object? fit = null,
    Object? origin = null,
    Object? specifications = null,
    Object? metaTitle = null,
    Object? metaDescription = null,
    Object? searchKeywords = null,
    Object? status = null,
    Object? isFeatured = null,
    Object? isNewArrival = null,
    Object? isBestseller = null,
    Object? isSale = null,
    Object? isExclusive = null,
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? ratingDistribution = null,
    Object? viewCount = null,
    Object? addToCartCount = null,
    Object? purchaseCount = null,
    Object? wishlistCount = null,
    Object? conversionRate = null,
    Object? popularityScore = null,
    Object? vendorId = freezed,
    Object? vendorName = freezed,
    Object? weight = freezed,
    Object? dimensions = null,
    Object? freeShipping = null,
    Object? shippingMethods = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? publishedAt = freezed,
    Object? deletedAt = freezed,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      brandId: null == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as String,
      brandName: null == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryPath: null == categoryPath
          ? _value.categoryPath
          : categoryPath // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subCategoryId: freezed == subCategoryId
          ? _value.subCategoryId
          : subCategoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      compareAtPrice: freezed == compareAtPrice
          ? _value.compareAtPrice
          : compareAtPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      totalStock: null == totalStock
          ? _value.totalStock
          : totalStock // ignore: cast_nullable_to_non_nullable
              as int,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as int,
      lowStockThreshold: null == lowStockThreshold
          ? _value.lowStockThreshold
          : lowStockThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ProductImage>,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      video360Url: freezed == video360Url
          ? _value.video360Url
          : video360Url // ignore: cast_nullable_to_non_nullable
              as String?,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as String,
      careInstructions: null == careInstructions
          ? _value.careInstructions
          : careInstructions // ignore: cast_nullable_to_non_nullable
              as String,
      fit: null == fit
          ? _value.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      specifications: null == specifications
          ? _value.specifications
          : specifications // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      metaTitle: null == metaTitle
          ? _value.metaTitle
          : metaTitle // ignore: cast_nullable_to_non_nullable
              as String,
      metaDescription: null == metaDescription
          ? _value.metaDescription
          : metaDescription // ignore: cast_nullable_to_non_nullable
              as String,
      searchKeywords: null == searchKeywords
          ? _value.searchKeywords
          : searchKeywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewArrival: null == isNewArrival
          ? _value.isNewArrival
          : isNewArrival // ignore: cast_nullable_to_non_nullable
              as bool,
      isBestseller: null == isBestseller
          ? _value.isBestseller
          : isBestseller // ignore: cast_nullable_to_non_nullable
              as bool,
      isSale: null == isSale
          ? _value.isSale
          : isSale // ignore: cast_nullable_to_non_nullable
              as bool,
      isExclusive: null == isExclusive
          ? _value.isExclusive
          : isExclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      ratingDistribution: null == ratingDistribution
          ? _value.ratingDistribution
          : ratingDistribution // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      addToCartCount: null == addToCartCount
          ? _value.addToCartCount
          : addToCartCount // ignore: cast_nullable_to_non_nullable
              as int,
      purchaseCount: null == purchaseCount
          ? _value.purchaseCount
          : purchaseCount // ignore: cast_nullable_to_non_nullable
              as int,
      wishlistCount: null == wishlistCount
          ? _value.wishlistCount
          : wishlistCount // ignore: cast_nullable_to_non_nullable
              as int,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
      popularityScore: null == popularityScore
          ? _value.popularityScore
          : popularityScore // ignore: cast_nullable_to_non_nullable
              as double,
      vendorId: freezed == vendorId
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorName: freezed == vendorName
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      dimensions: null == dimensions
          ? _value.dimensions
          : dimensions // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      freeShipping: null == freeShipping
          ? _value.freeShipping
          : freeShipping // ignore: cast_nullable_to_non_nullable
              as bool,
      shippingMethods: null == shippingMethods
          ? _value.shippingMethods
          : shippingMethods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
          _$ProductModelImpl value, $Res Function(_$ProductModelImpl) then) =
      __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sku,
      String name,
      String slug,
      String description,
      String? shortDescription,
      String brandId,
      String brandName,
      String categoryId,
      String categoryName,
      List<String> categoryPath,
      String? subCategoryId,
      List<String> tags,
      double basePrice,
      double sellingPrice,
      double? compareAtPrice,
      int discountPercentage,
      String currency,
      double? costPrice,
      int totalStock,
      int reservedStock,
      int lowStockThreshold,
      List<ProductImage> images,
      String thumbnailUrl,
      String? videoUrl,
      String? video360Url,
      String material,
      String careInstructions,
      String fit,
      String origin,
      Map<String, String> specifications,
      String metaTitle,
      String metaDescription,
      List<String> searchKeywords,
      String status,
      bool isFeatured,
      bool isNewArrival,
      bool isBestseller,
      bool isSale,
      bool isExclusive,
      double averageRating,
      int totalReviews,
      Map<int, int> ratingDistribution,
      int viewCount,
      int addToCartCount,
      int purchaseCount,
      int wishlistCount,
      double conversionRate,
      double popularityScore,
      String? vendorId,
      String? vendorName,
      double? weight,
      Map<String, double> dimensions,
      bool freeShipping,
      List<String> shippingMethods,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      @TimestampConverter() DateTime? publishedAt,
      @TimestampConverter() DateTime? deletedAt,
      String? createdBy,
      String? updatedBy,
      bool isDeleted});
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
      _$ProductModelImpl _value, $Res Function(_$ProductModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sku = null,
    Object? name = null,
    Object? slug = null,
    Object? description = null,
    Object? shortDescription = freezed,
    Object? brandId = null,
    Object? brandName = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categoryPath = null,
    Object? subCategoryId = freezed,
    Object? tags = null,
    Object? basePrice = null,
    Object? sellingPrice = null,
    Object? compareAtPrice = freezed,
    Object? discountPercentage = null,
    Object? currency = null,
    Object? costPrice = freezed,
    Object? totalStock = null,
    Object? reservedStock = null,
    Object? lowStockThreshold = null,
    Object? images = null,
    Object? thumbnailUrl = null,
    Object? videoUrl = freezed,
    Object? video360Url = freezed,
    Object? material = null,
    Object? careInstructions = null,
    Object? fit = null,
    Object? origin = null,
    Object? specifications = null,
    Object? metaTitle = null,
    Object? metaDescription = null,
    Object? searchKeywords = null,
    Object? status = null,
    Object? isFeatured = null,
    Object? isNewArrival = null,
    Object? isBestseller = null,
    Object? isSale = null,
    Object? isExclusive = null,
    Object? averageRating = null,
    Object? totalReviews = null,
    Object? ratingDistribution = null,
    Object? viewCount = null,
    Object? addToCartCount = null,
    Object? purchaseCount = null,
    Object? wishlistCount = null,
    Object? conversionRate = null,
    Object? popularityScore = null,
    Object? vendorId = freezed,
    Object? vendorName = freezed,
    Object? weight = freezed,
    Object? dimensions = null,
    Object? freeShipping = null,
    Object? shippingMethods = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? publishedAt = freezed,
    Object? deletedAt = freezed,
    Object? createdBy = freezed,
    Object? updatedBy = freezed,
    Object? isDeleted = null,
  }) {
    return _then(_$ProductModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      shortDescription: freezed == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      brandId: null == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as String,
      brandName: null == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryPath: null == categoryPath
          ? _value._categoryPath
          : categoryPath // ignore: cast_nullable_to_non_nullable
              as List<String>,
      subCategoryId: freezed == subCategoryId
          ? _value.subCategoryId
          : subCategoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      sellingPrice: null == sellingPrice
          ? _value.sellingPrice
          : sellingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      compareAtPrice: freezed == compareAtPrice
          ? _value.compareAtPrice
          : compareAtPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      costPrice: freezed == costPrice
          ? _value.costPrice
          : costPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      totalStock: null == totalStock
          ? _value.totalStock
          : totalStock // ignore: cast_nullable_to_non_nullable
              as int,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as int,
      lowStockThreshold: null == lowStockThreshold
          ? _value.lowStockThreshold
          : lowStockThreshold // ignore: cast_nullable_to_non_nullable
              as int,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<ProductImage>,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      video360Url: freezed == video360Url
          ? _value.video360Url
          : video360Url // ignore: cast_nullable_to_non_nullable
              as String?,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as String,
      careInstructions: null == careInstructions
          ? _value.careInstructions
          : careInstructions // ignore: cast_nullable_to_non_nullable
              as String,
      fit: null == fit
          ? _value.fit
          : fit // ignore: cast_nullable_to_non_nullable
              as String,
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      specifications: null == specifications
          ? _value._specifications
          : specifications // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      metaTitle: null == metaTitle
          ? _value.metaTitle
          : metaTitle // ignore: cast_nullable_to_non_nullable
              as String,
      metaDescription: null == metaDescription
          ? _value.metaDescription
          : metaDescription // ignore: cast_nullable_to_non_nullable
              as String,
      searchKeywords: null == searchKeywords
          ? _value._searchKeywords
          : searchKeywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      isNewArrival: null == isNewArrival
          ? _value.isNewArrival
          : isNewArrival // ignore: cast_nullable_to_non_nullable
              as bool,
      isBestseller: null == isBestseller
          ? _value.isBestseller
          : isBestseller // ignore: cast_nullable_to_non_nullable
              as bool,
      isSale: null == isSale
          ? _value.isSale
          : isSale // ignore: cast_nullable_to_non_nullable
              as bool,
      isExclusive: null == isExclusive
          ? _value.isExclusive
          : isExclusive // ignore: cast_nullable_to_non_nullable
              as bool,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
      ratingDistribution: null == ratingDistribution
          ? _value._ratingDistribution
          : ratingDistribution // ignore: cast_nullable_to_non_nullable
              as Map<int, int>,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      addToCartCount: null == addToCartCount
          ? _value.addToCartCount
          : addToCartCount // ignore: cast_nullable_to_non_nullable
              as int,
      purchaseCount: null == purchaseCount
          ? _value.purchaseCount
          : purchaseCount // ignore: cast_nullable_to_non_nullable
              as int,
      wishlistCount: null == wishlistCount
          ? _value.wishlistCount
          : wishlistCount // ignore: cast_nullable_to_non_nullable
              as int,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
      popularityScore: null == popularityScore
          ? _value.popularityScore
          : popularityScore // ignore: cast_nullable_to_non_nullable
              as double,
      vendorId: freezed == vendorId
          ? _value.vendorId
          : vendorId // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorName: freezed == vendorName
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      dimensions: null == dimensions
          ? _value._dimensions
          : dimensions // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      freeShipping: null == freeShipping
          ? _value.freeShipping
          : freeShipping // ignore: cast_nullable_to_non_nullable
              as bool,
      shippingMethods: null == shippingMethods
          ? _value._shippingMethods
          : shippingMethods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBy: freezed == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedBy: freezed == updatedBy
          ? _value.updatedBy
          : updatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl extends _ProductModel {
  const _$ProductModelImpl(
      {required this.id,
      required this.sku,
      required this.name,
      required this.slug,
      required this.description,
      this.shortDescription,
      required this.brandId,
      required this.brandName,
      required this.categoryId,
      required this.categoryName,
      final List<String> categoryPath = const <String>[],
      this.subCategoryId,
      final List<String> tags = const <String>[],
      required this.basePrice,
      required this.sellingPrice,
      this.compareAtPrice,
      this.discountPercentage = 0,
      this.currency = 'USD',
      this.costPrice,
      this.totalStock = 0,
      this.reservedStock = 0,
      this.lowStockThreshold = 10,
      final List<ProductImage> images = const <ProductImage>[],
      required this.thumbnailUrl,
      this.videoUrl,
      this.video360Url,
      this.material = '',
      this.careInstructions = '',
      this.fit = 'regular',
      this.origin = '',
      final Map<String, String> specifications = const <String, String>{},
      this.metaTitle = '',
      this.metaDescription = '',
      final List<String> searchKeywords = const <String>[],
      this.status = 'draft',
      this.isFeatured = false,
      this.isNewArrival = false,
      this.isBestseller = false,
      this.isSale = false,
      this.isExclusive = false,
      this.averageRating = 0.0,
      this.totalReviews = 0,
      final Map<int, int> ratingDistribution = const <int, int>{},
      this.viewCount = 0,
      this.addToCartCount = 0,
      this.purchaseCount = 0,
      this.wishlistCount = 0,
      this.conversionRate = 0.0,
      this.popularityScore = 0.0,
      this.vendorId,
      this.vendorName,
      this.weight,
      final Map<String, double> dimensions = const <String, double>{},
      this.freeShipping = false,
      final List<String> shippingMethods = const <String>[],
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt,
      @TimestampConverter() this.publishedAt,
      @TimestampConverter() this.deletedAt,
      this.createdBy,
      this.updatedBy,
      this.isDeleted = false})
      : _categoryPath = categoryPath,
        _tags = tags,
        _images = images,
        _specifications = specifications,
        _searchKeywords = searchKeywords,
        _ratingDistribution = ratingDistribution,
        _dimensions = dimensions,
        _shippingMethods = shippingMethods,
        super._();

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final String id;
  @override
  final String sku;
  @override
  final String name;
  @override
  final String slug;
  @override
  final String description;
  @override
  final String? shortDescription;
// Categorization
  @override
  final String brandId;
  @override
  final String brandName;
  @override
  final String categoryId;
  @override
  final String categoryName;
  final List<String> _categoryPath;
  @override
  @JsonKey()
  List<String> get categoryPath {
    if (_categoryPath is EqualUnmodifiableListView) return _categoryPath;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryPath);
  }

  @override
  final String? subCategoryId;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

// Pricing
  @override
  final double basePrice;
  @override
  final double sellingPrice;
  @override
  final double? compareAtPrice;
  @override
  @JsonKey()
  final int discountPercentage;
  @override
  @JsonKey()
  final String currency;
  @override
  final double? costPrice;
// 🔴 INVENTORY (SOURCE OF TRUTH ONLY)
  @override
  @JsonKey()
  final int totalStock;
  @override
  @JsonKey()
  final int reservedStock;
  @override
  @JsonKey()
  final int lowStockThreshold;
// Media
  final List<ProductImage> _images;
// Media
  @override
  @JsonKey()
  List<ProductImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String thumbnailUrl;
  @override
  final String? videoUrl;
  @override
  final String? video360Url;
// Product Details
  @override
  @JsonKey()
  final String material;
  @override
  @JsonKey()
  final String careInstructions;
  @override
  @JsonKey()
  final String fit;
  @override
  @JsonKey()
  final String origin;
  final Map<String, String> _specifications;
  @override
  @JsonKey()
  Map<String, String> get specifications {
    if (_specifications is EqualUnmodifiableMapView) return _specifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_specifications);
  }

// SEO & Search
  @override
  @JsonKey()
  final String metaTitle;
  @override
  @JsonKey()
  final String metaDescription;
  final List<String> _searchKeywords;
  @override
  @JsonKey()
  List<String> get searchKeywords {
    if (_searchKeywords is EqualUnmodifiableListView) return _searchKeywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchKeywords);
  }

// Status & Flags
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey()
  final bool isNewArrival;
  @override
  @JsonKey()
  final bool isBestseller;
  @override
  @JsonKey()
  final bool isSale;
  @override
  @JsonKey()
  final bool isExclusive;
// Ratings & Reviews
  @override
  @JsonKey()
  final double averageRating;
  @override
  @JsonKey()
  final int totalReviews;
  final Map<int, int> _ratingDistribution;
  @override
  @JsonKey()
  Map<int, int> get ratingDistribution {
    if (_ratingDistribution is EqualUnmodifiableMapView)
      return _ratingDistribution;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ratingDistribution);
  }

// Analytics
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int addToCartCount;
  @override
  @JsonKey()
  final int purchaseCount;
  @override
  @JsonKey()
  final int wishlistCount;
  @override
  @JsonKey()
  final double conversionRate;
  @override
  @JsonKey()
  final double popularityScore;
// Vendor Info
  @override
  final String? vendorId;
  @override
  final String? vendorName;
// Shipping
  @override
  final double? weight;
  final Map<String, double> _dimensions;
  @override
  @JsonKey()
  Map<String, double> get dimensions {
    if (_dimensions is EqualUnmodifiableMapView) return _dimensions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dimensions);
  }

  @override
  @JsonKey()
  final bool freeShipping;
  final List<String> _shippingMethods;
  @override
  @JsonKey()
  List<String> get shippingMethods {
    if (_shippingMethods is EqualUnmodifiableListView) return _shippingMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shippingMethods);
  }

// Timestamps
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  @TimestampConverter()
  final DateTime? publishedAt;
  @override
  @TimestampConverter()
  final DateTime? deletedAt;
// Metadata
  @override
  final String? createdBy;
  @override
  final String? updatedBy;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'ProductModel(id: $id, sku: $sku, name: $name, slug: $slug, description: $description, shortDescription: $shortDescription, brandId: $brandId, brandName: $brandName, categoryId: $categoryId, categoryName: $categoryName, categoryPath: $categoryPath, subCategoryId: $subCategoryId, tags: $tags, basePrice: $basePrice, sellingPrice: $sellingPrice, compareAtPrice: $compareAtPrice, discountPercentage: $discountPercentage, currency: $currency, costPrice: $costPrice, totalStock: $totalStock, reservedStock: $reservedStock, lowStockThreshold: $lowStockThreshold, images: $images, thumbnailUrl: $thumbnailUrl, videoUrl: $videoUrl, video360Url: $video360Url, material: $material, careInstructions: $careInstructions, fit: $fit, origin: $origin, specifications: $specifications, metaTitle: $metaTitle, metaDescription: $metaDescription, searchKeywords: $searchKeywords, status: $status, isFeatured: $isFeatured, isNewArrival: $isNewArrival, isBestseller: $isBestseller, isSale: $isSale, isExclusive: $isExclusive, averageRating: $averageRating, totalReviews: $totalReviews, ratingDistribution: $ratingDistribution, viewCount: $viewCount, addToCartCount: $addToCartCount, purchaseCount: $purchaseCount, wishlistCount: $wishlistCount, conversionRate: $conversionRate, popularityScore: $popularityScore, vendorId: $vendorId, vendorName: $vendorName, weight: $weight, dimensions: $dimensions, freeShipping: $freeShipping, shippingMethods: $shippingMethods, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt, deletedAt: $deletedAt, createdBy: $createdBy, updatedBy: $updatedBy, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            const DeepCollectionEquality()
                .equals(other._categoryPath, _categoryPath) &&
            (identical(other.subCategoryId, subCategoryId) ||
                other.subCategoryId == subCategoryId) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.sellingPrice, sellingPrice) ||
                other.sellingPrice == sellingPrice) &&
            (identical(other.compareAtPrice, compareAtPrice) ||
                other.compareAtPrice == compareAtPrice) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.costPrice, costPrice) ||
                other.costPrice == costPrice) &&
            (identical(other.totalStock, totalStock) ||
                other.totalStock == totalStock) &&
            (identical(other.reservedStock, reservedStock) ||
                other.reservedStock == reservedStock) &&
            (identical(other.lowStockThreshold, lowStockThreshold) ||
                other.lowStockThreshold == lowStockThreshold) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.video360Url, video360Url) ||
                other.video360Url == video360Url) &&
            (identical(other.material, material) ||
                other.material == material) &&
            (identical(other.careInstructions, careInstructions) ||
                other.careInstructions == careInstructions) &&
            (identical(other.fit, fit) || other.fit == fit) &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality()
                .equals(other._specifications, _specifications) &&
            (identical(other.metaTitle, metaTitle) ||
                other.metaTitle == metaTitle) &&
            (identical(other.metaDescription, metaDescription) ||
                other.metaDescription == metaDescription) &&
            const DeepCollectionEquality()
                .equals(other._searchKeywords, _searchKeywords) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isNewArrival, isNewArrival) ||
                other.isNewArrival == isNewArrival) &&
            (identical(other.isBestseller, isBestseller) ||
                other.isBestseller == isBestseller) &&
            (identical(other.isSale, isSale) || other.isSale == isSale) &&
            (identical(other.isExclusive, isExclusive) ||
                other.isExclusive == isExclusive) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews) &&
            const DeepCollectionEquality()
                .equals(other._ratingDistribution, _ratingDistribution) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.addToCartCount, addToCartCount) ||
                other.addToCartCount == addToCartCount) &&
            (identical(other.purchaseCount, purchaseCount) ||
                other.purchaseCount == purchaseCount) &&
            (identical(other.wishlistCount, wishlistCount) ||
                other.wishlistCount == wishlistCount) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate) &&
            (identical(other.popularityScore, popularityScore) ||
                other.popularityScore == popularityScore) &&
            (identical(other.vendorId, vendorId) ||
                other.vendorId == vendorId) &&
            (identical(other.vendorName, vendorName) ||
                other.vendorName == vendorName) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            const DeepCollectionEquality()
                .equals(other._dimensions, _dimensions) &&
            (identical(other.freeShipping, freeShipping) ||
                other.freeShipping == freeShipping) &&
            const DeepCollectionEquality().equals(other._shippingMethods, _shippingMethods) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt) &&
            (identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt) &&
            (identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt) &&
            (identical(other.createdBy, createdBy) || other.createdBy == createdBy) &&
            (identical(other.updatedBy, updatedBy) || other.updatedBy == updatedBy) &&
            (identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        sku,
        name,
        slug,
        description,
        shortDescription,
        brandId,
        brandName,
        categoryId,
        categoryName,
        const DeepCollectionEquality().hash(_categoryPath),
        subCategoryId,
        const DeepCollectionEquality().hash(_tags),
        basePrice,
        sellingPrice,
        compareAtPrice,
        discountPercentage,
        currency,
        costPrice,
        totalStock,
        reservedStock,
        lowStockThreshold,
        const DeepCollectionEquality().hash(_images),
        thumbnailUrl,
        videoUrl,
        video360Url,
        material,
        careInstructions,
        fit,
        origin,
        const DeepCollectionEquality().hash(_specifications),
        metaTitle,
        metaDescription,
        const DeepCollectionEquality().hash(_searchKeywords),
        status,
        isFeatured,
        isNewArrival,
        isBestseller,
        isSale,
        isExclusive,
        averageRating,
        totalReviews,
        const DeepCollectionEquality().hash(_ratingDistribution),
        viewCount,
        addToCartCount,
        purchaseCount,
        wishlistCount,
        conversionRate,
        popularityScore,
        vendorId,
        vendorName,
        weight,
        const DeepCollectionEquality().hash(_dimensions),
        freeShipping,
        const DeepCollectionEquality().hash(_shippingMethods),
        createdAt,
        updatedAt,
        publishedAt,
        deletedAt,
        createdBy,
        updatedBy,
        isDeleted
      ]);

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(
      this,
    );
  }
}

abstract class _ProductModel extends ProductModel {
  const factory _ProductModel(
      {required final String id,
      required final String sku,
      required final String name,
      required final String slug,
      required final String description,
      final String? shortDescription,
      required final String brandId,
      required final String brandName,
      required final String categoryId,
      required final String categoryName,
      final List<String> categoryPath,
      final String? subCategoryId,
      final List<String> tags,
      required final double basePrice,
      required final double sellingPrice,
      final double? compareAtPrice,
      final int discountPercentage,
      final String currency,
      final double? costPrice,
      final int totalStock,
      final int reservedStock,
      final int lowStockThreshold,
      final List<ProductImage> images,
      required final String thumbnailUrl,
      final String? videoUrl,
      final String? video360Url,
      final String material,
      final String careInstructions,
      final String fit,
      final String origin,
      final Map<String, String> specifications,
      final String metaTitle,
      final String metaDescription,
      final List<String> searchKeywords,
      final String status,
      final bool isFeatured,
      final bool isNewArrival,
      final bool isBestseller,
      final bool isSale,
      final bool isExclusive,
      final double averageRating,
      final int totalReviews,
      final Map<int, int> ratingDistribution,
      final int viewCount,
      final int addToCartCount,
      final int purchaseCount,
      final int wishlistCount,
      final double conversionRate,
      final double popularityScore,
      final String? vendorId,
      final String? vendorName,
      final double? weight,
      final Map<String, double> dimensions,
      final bool freeShipping,
      final List<String> shippingMethods,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt,
      @TimestampConverter() final DateTime? publishedAt,
      @TimestampConverter() final DateTime? deletedAt,
      final String? createdBy,
      final String? updatedBy,
      final bool isDeleted}) = _$ProductModelImpl;
  const _ProductModel._() : super._();

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  String get id;
  @override
  String get sku;
  @override
  String get name;
  @override
  String get slug;
  @override
  String get description;
  @override
  String? get shortDescription; // Categorization
  @override
  String get brandId;
  @override
  String get brandName;
  @override
  String get categoryId;
  @override
  String get categoryName;
  @override
  List<String> get categoryPath;
  @override
  String? get subCategoryId;
  @override
  List<String> get tags; // Pricing
  @override
  double get basePrice;
  @override
  double get sellingPrice;
  @override
  double? get compareAtPrice;
  @override
  int get discountPercentage;
  @override
  String get currency;
  @override
  double? get costPrice; // 🔴 INVENTORY (SOURCE OF TRUTH ONLY)
  @override
  int get totalStock;
  @override
  int get reservedStock;
  @override
  int get lowStockThreshold; // Media
  @override
  List<ProductImage> get images;
  @override
  String get thumbnailUrl;
  @override
  String? get videoUrl;
  @override
  String? get video360Url; // Product Details
  @override
  String get material;
  @override
  String get careInstructions;
  @override
  String get fit;
  @override
  String get origin;
  @override
  Map<String, String> get specifications; // SEO & Search
  @override
  String get metaTitle;
  @override
  String get metaDescription;
  @override
  List<String> get searchKeywords; // Status & Flags
  @override
  String get status;
  @override
  bool get isFeatured;
  @override
  bool get isNewArrival;
  @override
  bool get isBestseller;
  @override
  bool get isSale;
  @override
  bool get isExclusive; // Ratings & Reviews
  @override
  double get averageRating;
  @override
  int get totalReviews;
  @override
  Map<int, int> get ratingDistribution; // Analytics
  @override
  int get viewCount;
  @override
  int get addToCartCount;
  @override
  int get purchaseCount;
  @override
  int get wishlistCount;
  @override
  double get conversionRate;
  @override
  double get popularityScore; // Vendor Info
  @override
  String? get vendorId;
  @override
  String? get vendorName; // Shipping
  @override
  double? get weight;
  @override
  Map<String, double> get dimensions;
  @override
  bool get freeShipping;
  @override
  List<String> get shippingMethods; // Timestamps
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @TimestampConverter()
  DateTime? get publishedAt;
  @override
  @TimestampConverter()
  DateTime? get deletedAt; // Metadata
  @override
  String? get createdBy;
  @override
  String? get updatedBy;
  @override
  bool get isDeleted;

  /// Create a copy of ProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
