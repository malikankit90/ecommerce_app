// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) {
  return _OrderItemModel.fromJson(json);
}

/// @nodoc
mixin _$OrderItemModel {
  String get productId => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String get productSlug => throw _privateConstructorUsedError;
  String get brandName => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String? get variantId => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this OrderItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemModelCopyWith<OrderItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemModelCopyWith<$Res> {
  factory $OrderItemModelCopyWith(
          OrderItemModel value, $Res Function(OrderItemModel) then) =
      _$OrderItemModelCopyWithImpl<$Res, OrderItemModel>;
  @useResult
  $Res call(
      {String productId,
      String productName,
      String productSlug,
      String brandName,
      String thumbnailUrl,
      double price,
      int quantity,
      String? variantId,
      String? size,
      String? color});
}

/// @nodoc
class _$OrderItemModelCopyWithImpl<$Res, $Val extends OrderItemModel>
    implements $OrderItemModelCopyWith<$Res> {
  _$OrderItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? productSlug = null,
    Object? brandName = null,
    Object? thumbnailUrl = null,
    Object? price = null,
    Object? quantity = null,
    Object? variantId = freezed,
    Object? size = freezed,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
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
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderItemModelImplCopyWith<$Res>
    implements $OrderItemModelCopyWith<$Res> {
  factory _$$OrderItemModelImplCopyWith(_$OrderItemModelImpl value,
          $Res Function(_$OrderItemModelImpl) then) =
      __$$OrderItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String productId,
      String productName,
      String productSlug,
      String brandName,
      String thumbnailUrl,
      double price,
      int quantity,
      String? variantId,
      String? size,
      String? color});
}

/// @nodoc
class __$$OrderItemModelImplCopyWithImpl<$Res>
    extends _$OrderItemModelCopyWithImpl<$Res, _$OrderItemModelImpl>
    implements _$$OrderItemModelImplCopyWith<$Res> {
  __$$OrderItemModelImplCopyWithImpl(
      _$OrderItemModelImpl _value, $Res Function(_$OrderItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? productName = null,
    Object? productSlug = null,
    Object? brandName = null,
    Object? thumbnailUrl = null,
    Object? price = null,
    Object? quantity = null,
    Object? variantId = freezed,
    Object? size = freezed,
    Object? color = freezed,
  }) {
    return _then(_$OrderItemModelImpl(
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
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      variantId: freezed == variantId
          ? _value.variantId
          : variantId // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemModelImpl implements _OrderItemModel {
  const _$OrderItemModelImpl(
      {required this.productId,
      required this.productName,
      required this.productSlug,
      required this.brandName,
      required this.thumbnailUrl,
      required this.price,
      required this.quantity,
      this.variantId,
      this.size,
      this.color});

  factory _$OrderItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemModelImplFromJson(json);

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
  final int quantity;
  @override
  final String? variantId;
  @override
  final String? size;
  @override
  final String? color;

  @override
  String toString() {
    return 'OrderItemModel(productId: $productId, productName: $productName, productSlug: $productSlug, brandName: $brandName, thumbnailUrl: $thumbnailUrl, price: $price, quantity: $quantity, variantId: $variantId, size: $size, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemModelImpl &&
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
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.variantId, variantId) ||
                other.variantId == variantId) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      productId,
      productName,
      productSlug,
      brandName,
      thumbnailUrl,
      price,
      quantity,
      variantId,
      size,
      color);

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemModelImplCopyWith<_$OrderItemModelImpl> get copyWith =>
      __$$OrderItemModelImplCopyWithImpl<_$OrderItemModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemModelImplToJson(
      this,
    );
  }
}

abstract class _OrderItemModel implements OrderItemModel {
  const factory _OrderItemModel(
      {required final String productId,
      required final String productName,
      required final String productSlug,
      required final String brandName,
      required final String thumbnailUrl,
      required final double price,
      required final int quantity,
      final String? variantId,
      final String? size,
      final String? color}) = _$OrderItemModelImpl;

  factory _OrderItemModel.fromJson(Map<String, dynamic> json) =
      _$OrderItemModelImpl.fromJson;

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
  int get quantity;
  @override
  String? get variantId;
  @override
  String? get size;
  @override
  String? get color;

  /// Create a copy of OrderItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemModelImplCopyWith<_$OrderItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShippingAddressModel _$ShippingAddressModelFromJson(Map<String, dynamic> json) {
  return _ShippingAddressModel.fromJson(json);
}

/// @nodoc
mixin _$ShippingAddressModel {
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get addressLine1 => throw _privateConstructorUsedError;
  String? get addressLine2 => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get postalCode => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;

  /// Serializes this ShippingAddressModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShippingAddressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShippingAddressModelCopyWith<ShippingAddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShippingAddressModelCopyWith<$Res> {
  factory $ShippingAddressModelCopyWith(ShippingAddressModel value,
          $Res Function(ShippingAddressModel) then) =
      _$ShippingAddressModelCopyWithImpl<$Res, ShippingAddressModel>;
  @useResult
  $Res call(
      {String fullName,
      String phoneNumber,
      String addressLine1,
      String? addressLine2,
      String city,
      String state,
      String postalCode,
      String country});
}

/// @nodoc
class _$ShippingAddressModelCopyWithImpl<$Res,
        $Val extends ShippingAddressModel>
    implements $ShippingAddressModelCopyWith<$Res> {
  _$ShippingAddressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShippingAddressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? addressLine1 = null,
    Object? addressLine2 = freezed,
    Object? city = null,
    Object? state = null,
    Object? postalCode = null,
    Object? country = null,
  }) {
    return _then(_value.copyWith(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      addressLine1: null == addressLine1
          ? _value.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String,
      addressLine2: freezed == addressLine2
          ? _value.addressLine2
          : addressLine2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShippingAddressModelImplCopyWith<$Res>
    implements $ShippingAddressModelCopyWith<$Res> {
  factory _$$ShippingAddressModelImplCopyWith(_$ShippingAddressModelImpl value,
          $Res Function(_$ShippingAddressModelImpl) then) =
      __$$ShippingAddressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String fullName,
      String phoneNumber,
      String addressLine1,
      String? addressLine2,
      String city,
      String state,
      String postalCode,
      String country});
}

/// @nodoc
class __$$ShippingAddressModelImplCopyWithImpl<$Res>
    extends _$ShippingAddressModelCopyWithImpl<$Res, _$ShippingAddressModelImpl>
    implements _$$ShippingAddressModelImplCopyWith<$Res> {
  __$$ShippingAddressModelImplCopyWithImpl(_$ShippingAddressModelImpl _value,
      $Res Function(_$ShippingAddressModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShippingAddressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? addressLine1 = null,
    Object? addressLine2 = freezed,
    Object? city = null,
    Object? state = null,
    Object? postalCode = null,
    Object? country = null,
  }) {
    return _then(_$ShippingAddressModelImpl(
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      addressLine1: null == addressLine1
          ? _value.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String,
      addressLine2: freezed == addressLine2
          ? _value.addressLine2
          : addressLine2 // ignore: cast_nullable_to_non_nullable
              as String?,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String,
      postalCode: null == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShippingAddressModelImpl implements _ShippingAddressModel {
  const _$ShippingAddressModelImpl(
      {required this.fullName,
      required this.phoneNumber,
      required this.addressLine1,
      this.addressLine2,
      required this.city,
      required this.state,
      required this.postalCode,
      required this.country});

  factory _$ShippingAddressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShippingAddressModelImplFromJson(json);

  @override
  final String fullName;
  @override
  final String phoneNumber;
  @override
  final String addressLine1;
  @override
  final String? addressLine2;
  @override
  final String city;
  @override
  final String state;
  @override
  final String postalCode;
  @override
  final String country;

  @override
  String toString() {
    return 'ShippingAddressModel(fullName: $fullName, phoneNumber: $phoneNumber, addressLine1: $addressLine1, addressLine2: $addressLine2, city: $city, state: $state, postalCode: $postalCode, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShippingAddressModelImpl &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.addressLine1, addressLine1) ||
                other.addressLine1 == addressLine1) &&
            (identical(other.addressLine2, addressLine2) ||
                other.addressLine2 == addressLine2) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fullName, phoneNumber,
      addressLine1, addressLine2, city, state, postalCode, country);

  /// Create a copy of ShippingAddressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShippingAddressModelImplCopyWith<_$ShippingAddressModelImpl>
      get copyWith =>
          __$$ShippingAddressModelImplCopyWithImpl<_$ShippingAddressModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShippingAddressModelImplToJson(
      this,
    );
  }
}

abstract class _ShippingAddressModel implements ShippingAddressModel {
  const factory _ShippingAddressModel(
      {required final String fullName,
      required final String phoneNumber,
      required final String addressLine1,
      final String? addressLine2,
      required final String city,
      required final String state,
      required final String postalCode,
      required final String country}) = _$ShippingAddressModelImpl;

  factory _ShippingAddressModel.fromJson(Map<String, dynamic> json) =
      _$ShippingAddressModelImpl.fromJson;

  @override
  String get fullName;
  @override
  String get phoneNumber;
  @override
  String get addressLine1;
  @override
  String? get addressLine2;
  @override
  String get city;
  @override
  String get state;
  @override
  String get postalCode;
  @override
  String get country;

  /// Create a copy of ShippingAddressModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShippingAddressModelImplCopyWith<_$ShippingAddressModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderModel {
  /// 🔑 Firestore document ID (server-generated)
  String get id => throw _privateConstructorUsedError;

  /// 🔑 Auth UID
  String get userId => throw _privateConstructorUsedError;

  /// 🔁 IDEMPOTENCY KEY (client-generated, stable)
  String get idempotencyKey => throw _privateConstructorUsedError;

  /// Human-readable order number
  String get orderNumber =>
      throw _privateConstructorUsedError; // ---------------- ITEMS ----------------
  List<OrderItemModel> get items => throw _privateConstructorUsedError;
  int get totalItems =>
      throw _privateConstructorUsedError; // ---------------- PRICING ----------------
  double get subtotal => throw _privateConstructorUsedError;
  double get discount => throw _privateConstructorUsedError;
  double get shippingCost => throw _privateConstructorUsedError;
  double get tax => throw _privateConstructorUsedError;
  double get total =>
      throw _privateConstructorUsedError; // ---------------- SHIPPING ----------------
  ShippingAddressModel get shippingAddress =>
      throw _privateConstructorUsedError; // ---------------- PAYMENT ----------------
  String get paymentMethod => throw _privateConstructorUsedError;

  /// pending | paid | failed | refunded
  String get paymentStatus =>
      throw _privateConstructorUsedError; // ---------------- ORDER STATE ----------------
  /// payment_pending | confirmed | processing | shipped | delivered | cancelled | failed
  String get status =>
      throw _privateConstructorUsedError; // ---------------- TRACKING ----------------
  String? get trackingNumber => throw _privateConstructorUsedError;
  String? get carrier =>
      throw _privateConstructorUsedError; // ---------------- TIMESTAMPS ----------------
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get paidAt => throw _privateConstructorUsedError;
  DateTime? get confirmedAt => throw _privateConstructorUsedError;
  DateTime? get shippedAt => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  int? get createdAtMillis =>
      throw _privateConstructorUsedError; // ---------------- NOTES ----------------
  String? get customerNote => throw _privateConstructorUsedError;
  String? get adminNote => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String idempotencyKey,
      String orderNumber,
      List<OrderItemModel> items,
      int totalItems,
      double subtotal,
      double discount,
      double shippingCost,
      double tax,
      double total,
      ShippingAddressModel shippingAddress,
      String paymentMethod,
      String paymentStatus,
      String status,
      String? trackingNumber,
      String? carrier,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? paidAt,
      DateTime? confirmedAt,
      DateTime? shippedAt,
      DateTime? deliveredAt,
      DateTime? cancelledAt,
      int? createdAtMillis,
      String? customerNote,
      String? adminNote,
      bool isDeleted});

  $ShippingAddressModelCopyWith<$Res> get shippingAddress;
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? idempotencyKey = null,
    Object? orderNumber = null,
    Object? items = null,
    Object? totalItems = null,
    Object? subtotal = null,
    Object? discount = null,
    Object? shippingCost = null,
    Object? tax = null,
    Object? total = null,
    Object? shippingAddress = null,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? status = null,
    Object? trackingNumber = freezed,
    Object? carrier = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? paidAt = freezed,
    Object? confirmedAt = freezed,
    Object? shippedAt = freezed,
    Object? deliveredAt = freezed,
    Object? cancelledAt = freezed,
    Object? createdAtMillis = freezed,
    Object? customerNote = freezed,
    Object? adminNote = freezed,
    Object? isDeleted = null,
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
      idempotencyKey: null == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItemModel>,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      shippingCost: null == shippingCost
          ? _value.shippingCost
          : shippingCost // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      shippingAddress: null == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as ShippingAddressModel,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      carrier: freezed == carrier
          ? _value.carrier
          : carrier // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shippedAt: freezed == shippedAt
          ? _value.shippedAt
          : shippedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAtMillis: freezed == createdAtMillis
          ? _value.createdAtMillis
          : createdAtMillis // ignore: cast_nullable_to_non_nullable
              as int?,
      customerNote: freezed == customerNote
          ? _value.customerNote
          : customerNote // ignore: cast_nullable_to_non_nullable
              as String?,
      adminNote: freezed == adminNote
          ? _value.adminNote
          : adminNote // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShippingAddressModelCopyWith<$Res> get shippingAddress {
    return $ShippingAddressModelCopyWith<$Res>(_value.shippingAddress, (value) {
      return _then(_value.copyWith(shippingAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
          _$OrderModelImpl value, $Res Function(_$OrderModelImpl) then) =
      __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String idempotencyKey,
      String orderNumber,
      List<OrderItemModel> items,
      int totalItems,
      double subtotal,
      double discount,
      double shippingCost,
      double tax,
      double total,
      ShippingAddressModel shippingAddress,
      String paymentMethod,
      String paymentStatus,
      String status,
      String? trackingNumber,
      String? carrier,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? paidAt,
      DateTime? confirmedAt,
      DateTime? shippedAt,
      DateTime? deliveredAt,
      DateTime? cancelledAt,
      int? createdAtMillis,
      String? customerNote,
      String? adminNote,
      bool isDeleted});

  @override
  $ShippingAddressModelCopyWith<$Res> get shippingAddress;
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
      _$OrderModelImpl _value, $Res Function(_$OrderModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? idempotencyKey = null,
    Object? orderNumber = null,
    Object? items = null,
    Object? totalItems = null,
    Object? subtotal = null,
    Object? discount = null,
    Object? shippingCost = null,
    Object? tax = null,
    Object? total = null,
    Object? shippingAddress = null,
    Object? paymentMethod = null,
    Object? paymentStatus = null,
    Object? status = null,
    Object? trackingNumber = freezed,
    Object? carrier = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? paidAt = freezed,
    Object? confirmedAt = freezed,
    Object? shippedAt = freezed,
    Object? deliveredAt = freezed,
    Object? cancelledAt = freezed,
    Object? createdAtMillis = freezed,
    Object? customerNote = freezed,
    Object? adminNote = freezed,
    Object? isDeleted = null,
  }) {
    return _then(_$OrderModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      idempotencyKey: null == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String,
      orderNumber: null == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItemModel>,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      discount: null == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as double,
      shippingCost: null == shippingCost
          ? _value.shippingCost
          : shippingCost // ignore: cast_nullable_to_non_nullable
              as double,
      tax: null == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as double,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      shippingAddress: null == shippingAddress
          ? _value.shippingAddress
          : shippingAddress // ignore: cast_nullable_to_non_nullable
              as ShippingAddressModel,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      trackingNumber: freezed == trackingNumber
          ? _value.trackingNumber
          : trackingNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      carrier: freezed == carrier
          ? _value.carrier
          : carrier // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      confirmedAt: freezed == confirmedAt
          ? _value.confirmedAt
          : confirmedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      shippedAt: freezed == shippedAt
          ? _value.shippedAt
          : shippedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAtMillis: freezed == createdAtMillis
          ? _value.createdAtMillis
          : createdAtMillis // ignore: cast_nullable_to_non_nullable
              as int?,
      customerNote: freezed == customerNote
          ? _value.customerNote
          : customerNote // ignore: cast_nullable_to_non_nullable
              as String?,
      adminNote: freezed == adminNote
          ? _value.adminNote
          : adminNote // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$OrderModelImpl extends _OrderModel {
  const _$OrderModelImpl(
      {required this.id,
      required this.userId,
      required this.idempotencyKey,
      required this.orderNumber,
      required final List<OrderItemModel> items,
      required this.totalItems,
      required this.subtotal,
      required this.discount,
      required this.shippingCost,
      required this.tax,
      required this.total,
      required this.shippingAddress,
      required this.paymentMethod,
      this.paymentStatus = 'pending',
      this.status = 'payment_pending',
      this.trackingNumber,
      this.carrier,
      this.createdAt,
      this.updatedAt,
      this.paidAt,
      this.confirmedAt,
      this.shippedAt,
      this.deliveredAt,
      this.cancelledAt,
      this.createdAtMillis,
      this.customerNote,
      this.adminNote,
      this.isDeleted = false})
      : _items = items,
        super._();

  /// 🔑 Firestore document ID (server-generated)
  @override
  final String id;

  /// 🔑 Auth UID
  @override
  final String userId;

  /// 🔁 IDEMPOTENCY KEY (client-generated, stable)
  @override
  final String idempotencyKey;

  /// Human-readable order number
  @override
  final String orderNumber;
// ---------------- ITEMS ----------------
  final List<OrderItemModel> _items;
// ---------------- ITEMS ----------------
  @override
  List<OrderItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int totalItems;
// ---------------- PRICING ----------------
  @override
  final double subtotal;
  @override
  final double discount;
  @override
  final double shippingCost;
  @override
  final double tax;
  @override
  final double total;
// ---------------- SHIPPING ----------------
  @override
  final ShippingAddressModel shippingAddress;
// ---------------- PAYMENT ----------------
  @override
  final String paymentMethod;

  /// pending | paid | failed | refunded
  @override
  @JsonKey()
  final String paymentStatus;
// ---------------- ORDER STATE ----------------
  /// payment_pending | confirmed | processing | shipped | delivered | cancelled | failed
  @override
  @JsonKey()
  final String status;
// ---------------- TRACKING ----------------
  @override
  final String? trackingNumber;
  @override
  final String? carrier;
// ---------------- TIMESTAMPS ----------------
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? paidAt;
  @override
  final DateTime? confirmedAt;
  @override
  final DateTime? shippedAt;
  @override
  final DateTime? deliveredAt;
  @override
  final DateTime? cancelledAt;
  @override
  final int? createdAtMillis;
// ---------------- NOTES ----------------
  @override
  final String? customerNote;
  @override
  final String? adminNote;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'OrderModel(id: $id, userId: $userId, idempotencyKey: $idempotencyKey, orderNumber: $orderNumber, items: $items, totalItems: $totalItems, subtotal: $subtotal, discount: $discount, shippingCost: $shippingCost, tax: $tax, total: $total, shippingAddress: $shippingAddress, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, status: $status, trackingNumber: $trackingNumber, carrier: $carrier, createdAt: $createdAt, updatedAt: $updatedAt, paidAt: $paidAt, confirmedAt: $confirmedAt, shippedAt: $shippedAt, deliveredAt: $deliveredAt, cancelledAt: $cancelledAt, createdAtMillis: $createdAtMillis, customerNote: $customerNote, adminNote: $adminNote, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.shippingCost, shippingCost) ||
                other.shippingCost == shippingCost) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.shippingAddress, shippingAddress) ||
                other.shippingAddress == shippingAddress) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.trackingNumber, trackingNumber) ||
                other.trackingNumber == trackingNumber) &&
            (identical(other.carrier, carrier) || other.carrier == carrier) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            (identical(other.confirmedAt, confirmedAt) ||
                other.confirmedAt == confirmedAt) &&
            (identical(other.shippedAt, shippedAt) ||
                other.shippedAt == shippedAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.createdAtMillis, createdAtMillis) ||
                other.createdAtMillis == createdAtMillis) &&
            (identical(other.customerNote, customerNote) ||
                other.customerNote == customerNote) &&
            (identical(other.adminNote, adminNote) ||
                other.adminNote == adminNote) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        idempotencyKey,
        orderNumber,
        const DeepCollectionEquality().hash(_items),
        totalItems,
        subtotal,
        discount,
        shippingCost,
        tax,
        total,
        shippingAddress,
        paymentMethod,
        paymentStatus,
        status,
        trackingNumber,
        carrier,
        createdAt,
        updatedAt,
        paidAt,
        confirmedAt,
        shippedAt,
        deliveredAt,
        cancelledAt,
        createdAtMillis,
        customerNote,
        adminNote,
        isDeleted
      ]);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);
}

abstract class _OrderModel extends OrderModel {
  const factory _OrderModel(
      {required final String id,
      required final String userId,
      required final String idempotencyKey,
      required final String orderNumber,
      required final List<OrderItemModel> items,
      required final int totalItems,
      required final double subtotal,
      required final double discount,
      required final double shippingCost,
      required final double tax,
      required final double total,
      required final ShippingAddressModel shippingAddress,
      required final String paymentMethod,
      final String paymentStatus,
      final String status,
      final String? trackingNumber,
      final String? carrier,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? paidAt,
      final DateTime? confirmedAt,
      final DateTime? shippedAt,
      final DateTime? deliveredAt,
      final DateTime? cancelledAt,
      final int? createdAtMillis,
      final String? customerNote,
      final String? adminNote,
      final bool isDeleted}) = _$OrderModelImpl;
  const _OrderModel._() : super._();

  /// 🔑 Firestore document ID (server-generated)
  @override
  String get id;

  /// 🔑 Auth UID
  @override
  String get userId;

  /// 🔁 IDEMPOTENCY KEY (client-generated, stable)
  @override
  String get idempotencyKey;

  /// Human-readable order number
  @override
  String get orderNumber; // ---------------- ITEMS ----------------
  @override
  List<OrderItemModel> get items;
  @override
  int get totalItems; // ---------------- PRICING ----------------
  @override
  double get subtotal;
  @override
  double get discount;
  @override
  double get shippingCost;
  @override
  double get tax;
  @override
  double get total; // ---------------- SHIPPING ----------------
  @override
  ShippingAddressModel
      get shippingAddress; // ---------------- PAYMENT ----------------
  @override
  String get paymentMethod;

  /// pending | paid | failed | refunded
  @override
  String get paymentStatus; // ---------------- ORDER STATE ----------------
  /// payment_pending | confirmed | processing | shipped | delivered | cancelled | failed
  @override
  String get status; // ---------------- TRACKING ----------------
  @override
  String? get trackingNumber;
  @override
  String? get carrier; // ---------------- TIMESTAMPS ----------------
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get paidAt;
  @override
  DateTime? get confirmedAt;
  @override
  DateTime? get shippedAt;
  @override
  DateTime? get deliveredAt;
  @override
  DateTime? get cancelledAt;
  @override
  int? get createdAtMillis; // ---------------- NOTES ----------------
  @override
  String? get customerNote;
  @override
  String? get adminNote;
  @override
  bool get isDeleted;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
