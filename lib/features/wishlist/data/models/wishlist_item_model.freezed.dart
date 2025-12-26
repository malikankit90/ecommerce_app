// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WishlistItemModel _$WishlistItemModelFromJson(Map<String, dynamic> json) {
  return _WishlistItemModel.fromJson(json);
}

/// @nodoc
mixin _$WishlistItemModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String get productSlug => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double? get compareAtPrice => throw _privateConstructorUsedError;

  /// Soft availability hint (NOT authoritative)
  bool get inStock => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get addedAt => throw _privateConstructorUsedError;

  /// Serializes this WishlistItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WishlistItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WishlistItemModelCopyWith<WishlistItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistItemModelCopyWith<$Res> {
  factory $WishlistItemModelCopyWith(
          WishlistItemModel value, $Res Function(WishlistItemModel) then) =
      _$WishlistItemModelCopyWithImpl<$Res, WishlistItemModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String productId,
      String productName,
      String productSlug,
      String brandName,
      String thumbnailUrl,
      double price,
      double? compareAtPrice,
      bool inStock,
      @TimestampConverter() DateTime? addedAt});
}

/// @nodoc
class _$WishlistItemModelCopyWithImpl<$Res, $Val extends WishlistItemModel>
    implements $WishlistItemModelCopyWith<$Res> {
  _$WishlistItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WishlistItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? productName = null,
    Object? productSlug = null,
    Object? brandName = null,
    Object? thumbnailUrl = null,
    Object? price = null,
    Object? compareAtPrice = freezed,
    Object? inStock = null,
    Object? addedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productSlug: null == productSlug
          ? _value.productSlug
          : productSlug // ignore: cast_nullable_to_non_nullable
              as String,
      brandName: null == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      compareAtPrice: freezed == compareAtPrice
          ? _value.compareAtPrice
          : compareAtPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      inStock: null == inStock
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as bool,
      addedAt: freezed == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WishlistItemModelImplCopyWith<$Res>
    implements $WishlistItemModelCopyWith<$Res> {
  factory _$$WishlistItemModelImplCopyWith(_$WishlistItemModelImpl value,
          $Res Function(_$WishlistItemModelImpl) then) =
      __$$WishlistItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String productId,
      String productName,
      String productSlug,
      String brandName,
      String thumbnailUrl,
      double price,
      double? compareAtPrice,
      bool inStock,
      @TimestampConverter() DateTime? addedAt});
}

/// @nodoc
class __$$WishlistItemModelImplCopyWithImpl<$Res>
    extends _$WishlistItemModelCopyWithImpl<$Res, _$WishlistItemModelImpl>
    implements _$$WishlistItemModelImplCopyWith<$Res> {
  __$$WishlistItemModelImplCopyWithImpl(_$WishlistItemModelImpl _value,
      $Res Function(_$WishlistItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WishlistItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? productId = null,
    Object? productName = null,
    Object? productSlug = null,
    Object? brandName = null,
    Object? thumbnailUrl = null,
    Object? price = null,
    Object? compareAtPrice = freezed,
    Object? inStock = null,
    Object? addedAt = freezed,
  }) {
    return _then(_$WishlistItemModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productSlug: null == productSlug
          ? _value.productSlug
          : productSlug // ignore: cast_nullable_to_non_nullable
              as String,
      brandName: null == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      compareAtPrice: freezed == compareAtPrice
          ? _value.compareAtPrice
          : compareAtPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      inStock: null == inStock
          ? _value.inStock
          : inStock // ignore: cast_nullable_to_non_nullable
              as bool,
      addedAt: freezed == addedAt
          ? _value.addedAt
          : addedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WishlistItemModelImpl extends _WishlistItemModel {
  const _$WishlistItemModelImpl(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.productName,
      required this.productSlug,
      required this.brandName,
      required this.thumbnailUrl,
      required this.price,
      this.compareAtPrice,
      required this.inStock,
      @TimestampConverter() this.addedAt})
      : super._();

  factory _$WishlistItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishlistItemModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String productId;
  @override
  final String productName;
  @override
  final String productSlug;
  @override
  final String brandName;
  @override
  final String thumbnailUrl;
  @override
  final double price;
  @override
  final double? compareAtPrice;

  /// Soft availability hint (NOT authoritative)
  @override
  final bool inStock;
  @override
  @TimestampConverter()
  final DateTime? addedAt;

  @override
  String toString() {
    return 'WishlistItemModel(id: $id, userId: $userId, productId: $productId, productName: $productName, productSlug: $productSlug, brandName: $brandName, thumbnailUrl: $thumbnailUrl, price: $price, compareAtPrice: $compareAtPrice, inStock: $inStock, addedAt: $addedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishlistItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productSlug, productSlug) ||
                other.productSlug == productSlug) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.compareAtPrice, compareAtPrice) ||
                other.compareAtPrice == compareAtPrice) &&
            (identical(other.inStock, inStock) || other.inStock == inStock) &&
            (identical(other.addedAt, addedAt) || other.addedAt == addedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      productId,
      productName,
      productSlug,
      brandName,
      thumbnailUrl,
      price,
      compareAtPrice,
      inStock,
      addedAt);

  /// Create a copy of WishlistItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WishlistItemModelImplCopyWith<_$WishlistItemModelImpl> get copyWith =>
      __$$WishlistItemModelImplCopyWithImpl<_$WishlistItemModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WishlistItemModelImplToJson(
      this,
    );
  }
}

abstract class _WishlistItemModel extends WishlistItemModel {
  const factory _WishlistItemModel(
      {required final String id,
      required final String userId,
      required final String productId,
      required final String productName,
      required final String productSlug,
      required final String brandName,
      required final String thumbnailUrl,
      required final double price,
      final double? compareAtPrice,
      required final bool inStock,
      @TimestampConverter() final DateTime? addedAt}) = _$WishlistItemModelImpl;
  const _WishlistItemModel._() : super._();

  factory _WishlistItemModel.fromJson(Map<String, dynamic> json) =
      _$WishlistItemModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get productId;
  @override
  String get productName;
  @override
  String get productSlug;
  @override
  String get brandName;
  @override
  String get thumbnailUrl;
  @override
  double get price;
  @override
  double? get compareAtPrice;

  /// Soft availability hint (NOT authoritative)
  @override
  bool get inStock;
  @override
  @TimestampConverter()
  DateTime? get addedAt;

  /// Create a copy of WishlistItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WishlistItemModelImplCopyWith<_$WishlistItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
