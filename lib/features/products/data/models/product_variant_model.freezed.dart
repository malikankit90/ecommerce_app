// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_variant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductVariantModel _$ProductVariantModelFromJson(Map<String, dynamic> json) {
  return _ProductVariantModel.fromJson(json);
}

/// @nodoc
mixin _$ProductVariantModel {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get sku => throw _privateConstructorUsedError; // Variant Attributes
  String get size => throw _privateConstructorUsedError;
  String? get sizeLabel => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get colorHex => throw _privateConstructorUsedError;
  String? get colorFamily =>
      throw _privateConstructorUsedError; // Pricing (if variant has different price)
  double? get price => throw _privateConstructorUsedError;
  double? get compareAtPrice => throw _privateConstructorUsedError; // Inventory
  int get stock => throw _privateConstructorUsedError;
  int get reservedStock => throw _privateConstructorUsedError;
  int get availableStock => throw _privateConstructorUsedError;
  bool get inStock => throw _privateConstructorUsedError;
  String? get warehouseLocation => throw _privateConstructorUsedError; // Media
  List<String> get imageUrls => throw _privateConstructorUsedError; // Barcode
  String? get barcode => throw _privateConstructorUsedError;
  String? get ean => throw _privateConstructorUsedError;
  String? get upc => throw _privateConstructorUsedError; // Status
  bool get isActive => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError; // Timestamps
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ProductVariantModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductVariantModelCopyWith<ProductVariantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductVariantModelCopyWith<$Res> {
  factory $ProductVariantModelCopyWith(
          ProductVariantModel value, $Res Function(ProductVariantModel) then) =
      _$ProductVariantModelCopyWithImpl<$Res, ProductVariantModel>;
  @useResult
  $Res call(
      {String id,
      String productId,
      String sku,
      String size,
      String? sizeLabel,
      String color,
      String colorHex,
      String? colorFamily,
      double? price,
      double? compareAtPrice,
      int stock,
      int reservedStock,
      int availableStock,
      bool inStock,
      String? warehouseLocation,
      List<String> imageUrls,
      String? barcode,
      String? ean,
      String? upc,
      bool isActive,
      bool isDeleted,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$ProductVariantModelCopyWithImpl<$Res, $Val extends ProductVariantModel>
    implements $ProductVariantModelCopyWith<$Res> {
  _$ProductVariantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? sku = null,
    Object? size = null,
    Object? sizeLabel = freezed,
    Object? color = null,
    Object? colorHex = null,
    Object? colorFamily = freezed,
    Object? price = freezed,
    Object? compareAtPrice = freezed,
    Object? stock = null,
    Object? reservedStock = null,
    Object? availableStock = null,
    Object? inStock = null,
    Object? warehouseLocation = freezed,
    Object? imageUrls = null,
    Object? barcode = freezed,
    Object? ean = freezed,
    Object? upc = freezed,
    Object? isActive = null,
    Object? isDeleted = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      sizeLabel: freezed == sizeLabel
          ? _value.sizeLabel
          : sizeLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: null == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
      colorFamily: freezed == colorFamily
          ? _value.colorFamily
          : colorFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      compareAtPrice: freezed == compareAtPrice
          ? _value.compareAtPrice
          : compareAtPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as int,
      availableStock: null == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as int,
      inStock: null == inStock
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as bool,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      ean: freezed == ean
          ? _value.ean
          : ean // ignore: cast_nullable_to_non_nullable
              as String?,
      upc: freezed == upc
          ? _value.upc
          : upc // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductVariantModelImplCopyWith<$Res>
    implements $ProductVariantModelCopyWith<$Res> {
  factory _$$ProductVariantModelImplCopyWith(_$ProductVariantModelImpl value,
          $Res Function(_$ProductVariantModelImpl) then) =
      __$$ProductVariantModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String productId,
      String sku,
      String size,
      String? sizeLabel,
      String color,
      String colorHex,
      String? colorFamily,
      double? price,
      double? compareAtPrice,
      int stock,
      int reservedStock,
      int availableStock,
      bool inStock,
      String? warehouseLocation,
      List<String> imageUrls,
      String? barcode,
      String? ean,
      String? upc,
      bool isActive,
      bool isDeleted,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$ProductVariantModelImplCopyWithImpl<$Res>
    extends _$ProductVariantModelCopyWithImpl<$Res, _$ProductVariantModelImpl>
    implements _$$ProductVariantModelImplCopyWith<$Res> {
  __$$ProductVariantModelImplCopyWithImpl(_$ProductVariantModelImpl _value,
      $Res Function(_$ProductVariantModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? sku = null,
    Object? size = null,
    Object? sizeLabel = freezed,
    Object? color = null,
    Object? colorHex = null,
    Object? colorFamily = freezed,
    Object? price = freezed,
    Object? compareAtPrice = freezed,
    Object? stock = null,
    Object? reservedStock = null,
    Object? availableStock = null,
    Object? inStock = null,
    Object? warehouseLocation = freezed,
    Object? imageUrls = null,
    Object? barcode = freezed,
    Object? ean = freezed,
    Object? upc = freezed,
    Object? isActive = null,
    Object? isDeleted = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ProductVariantModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      sku: null == sku
          ? _value.sku
          : sku // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      sizeLabel: freezed == sizeLabel
          ? _value.sizeLabel
          : sizeLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      colorHex: null == colorHex
          ? _value.colorHex
          : colorHex // ignore: cast_nullable_to_non_nullable
              as String,
      colorFamily: freezed == colorFamily
          ? _value.colorFamily
          : colorFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      compareAtPrice: freezed == compareAtPrice
          ? _value.compareAtPrice
          : compareAtPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      stock: null == stock
          ? _value.stock
          : stock // ignore: cast_nullable_to_non_nullable
              as int,
      reservedStock: null == reservedStock
          ? _value.reservedStock
          : reservedStock // ignore: cast_nullable_to_non_nullable
              as int,
      availableStock: null == availableStock
          ? _value.availableStock
          : availableStock // ignore: cast_nullable_to_non_nullable
              as int,
      inStock: null == inStock
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as bool,
      warehouseLocation: freezed == warehouseLocation
          ? _value.warehouseLocation
          : warehouseLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      ean: freezed == ean
          ? _value.ean
          : ean // ignore: cast_nullable_to_non_nullable
              as String?,
      upc: freezed == upc
          ? _value.upc
          : upc // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductVariantModelImpl extends _ProductVariantModel {
  const _$ProductVariantModelImpl(
      {required this.id,
      required this.productId,
      required this.sku,
      required this.size,
      this.sizeLabel,
      required this.color,
      required this.colorHex,
      this.colorFamily,
      this.price,
      this.compareAtPrice,
      this.stock = 0,
      this.reservedStock = 0,
      this.availableStock = 0,
      this.inStock = false,
      this.warehouseLocation,
      final List<String> imageUrls = const <String>[],
      this.barcode,
      this.ean,
      this.upc,
      this.isActive = true,
      this.isDeleted = false,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : _imageUrls = imageUrls,
        super._();

  factory _$ProductVariantModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductVariantModelImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String sku;
// Variant Attributes
  @override
  final String size;
  @override
  final String? sizeLabel;
  @override
  final String color;
  @override
  final String colorHex;
  @override
  final String? colorFamily;
// Pricing (if variant has different price)
  @override
  final double? price;
  @override
  final double? compareAtPrice;
// Inventory
  @override
  @JsonKey()
  final int stock;
  @override
  @JsonKey()
  final int reservedStock;
  @override
  @JsonKey()
  final int availableStock;
  @override
  @JsonKey()
  final bool inStock;
  @override
  final String? warehouseLocation;
// Media
  final List<String> _imageUrls;
// Media
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

// Barcode
  @override
  final String? barcode;
  @override
  final String? ean;
  @override
  final String? upc;
// Status
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isDeleted;
// Timestamps
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ProductVariantModel(id: $id, productId: $productId, sku: $sku, size: $size, sizeLabel: $sizeLabel, color: $color, colorHex: $colorHex, colorFamily: $colorFamily, price: $price, compareAtPrice: $compareAtPrice, stock: $stock, reservedStock: $reservedStock, availableStock: $availableStock, inStock: $inStock, warehouseLocation: $warehouseLocation, imageUrls: $imageUrls, barcode: $barcode, ean: $ean, upc: $upc, isActive: $isActive, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductVariantModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.sku, sku) || other.sku == sku) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.sizeLabel, sizeLabel) ||
                other.sizeLabel == sizeLabel) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.colorFamily, colorFamily) ||
                other.colorFamily == colorFamily) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.compareAtPrice, compareAtPrice) ||
                other.compareAtPrice == compareAtPrice) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.reservedStock, reservedStock) ||
                other.reservedStock == reservedStock) &&
            (identical(other.availableStock, availableStock) ||
                other.availableStock == availableStock) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            (identical(other.warehouseLocation, warehouseLocation) ||
                other.warehouseLocation == warehouseLocation) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.ean, ean) || other.ean == ean) &&
            (identical(other.upc, upc) || other.upc == upc) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        productId,
        sku,
        size,
        sizeLabel,
        color,
        colorHex,
        colorFamily,
        price,
        compareAtPrice,
        stock,
        reservedStock,
        availableStock,
        inStock,
        warehouseLocation,
        const DeepCollectionEquality().hash(_imageUrls),
        barcode,
        ean,
        upc,
        isActive,
        isDeleted,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductVariantModelImplCopyWith<_$ProductVariantModelImpl> get copyWith =>
      __$$ProductVariantModelImplCopyWithImpl<_$ProductVariantModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductVariantModelImplToJson(
      this,
    );
  }
}

abstract class _ProductVariantModel extends ProductVariantModel {
  const factory _ProductVariantModel(
          {required final String id,
          required final String productId,
          required final String sku,
          required final String size,
          final String? sizeLabel,
          required final String color,
          required final String colorHex,
          final String? colorFamily,
          final double? price,
          final double? compareAtPrice,
          final int stock,
          final int reservedStock,
          final int availableStock,
          final bool inStock,
          final String? warehouseLocation,
          final List<String> imageUrls,
          final String? barcode,
          final String? ean,
          final String? upc,
          final bool isActive,
          final bool isDeleted,
          @TimestampConverter() final DateTime? createdAt,
          @TimestampConverter() final DateTime? updatedAt}) =
      _$ProductVariantModelImpl;
  const _ProductVariantModel._() : super._();

  factory _ProductVariantModel.fromJson(Map<String, dynamic> json) =
      _$ProductVariantModelImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  String get sku; // Variant Attributes
  @override
  String get size;
  @override
  String? get sizeLabel;
  @override
  String get color;
  @override
  String get colorHex;
  @override
  String? get colorFamily; // Pricing (if variant has different price)
  @override
  double? get price;
  @override
  double? get compareAtPrice; // Inventory
  @override
  int get stock;
  @override
  int get reservedStock;
  @override
  int get availableStock;
  @override
  bool get inStock;
  @override
  String? get warehouseLocation; // Media
  @override
  List<String> get imageUrls; // Barcode
  @override
  String? get barcode;
  @override
  String? get ean;
  @override
  String? get upc; // Status
  @override
  bool get isActive;
  @override
  bool get isDeleted; // Timestamps
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of ProductVariantModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductVariantModelImplCopyWith<_$ProductVariantModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
