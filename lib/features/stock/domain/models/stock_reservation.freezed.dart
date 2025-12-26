// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StockReservation _$StockReservationFromJson(Map<String, dynamic> json) {
  return _StockReservation.fromJson(json);
}

/// @nodoc
mixin _$StockReservation {
  String get id => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get orderId => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // active | committed | released | expired
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this StockReservation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StockReservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StockReservationCopyWith<StockReservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockReservationCopyWith<$Res> {
  factory $StockReservationCopyWith(
          StockReservation value, $Res Function(StockReservation) then) =
      _$StockReservationCopyWithImpl<$Res, StockReservation>;
  @useResult
  $Res call(
      {String id,
      String productId,
      int quantity,
      String orderId,
      String status,
      DateTime? expiresAt,
      DateTime? createdAt});
}

/// @nodoc
class _$StockReservationCopyWithImpl<$Res, $Val extends StockReservation>
    implements $StockReservationCopyWith<$Res> {
  _$StockReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StockReservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? quantity = null,
    Object? orderId = null,
    Object? status = null,
    Object? expiresAt = freezed,
    Object? createdAt = freezed,
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
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockReservationImplCopyWith<$Res>
    implements $StockReservationCopyWith<$Res> {
  factory _$$StockReservationImplCopyWith(_$StockReservationImpl value,
          $Res Function(_$StockReservationImpl) then) =
      __$$StockReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String productId,
      int quantity,
      String orderId,
      String status,
      DateTime? expiresAt,
      DateTime? createdAt});
}

/// @nodoc
class __$$StockReservationImplCopyWithImpl<$Res>
    extends _$StockReservationCopyWithImpl<$Res, _$StockReservationImpl>
    implements _$$StockReservationImplCopyWith<$Res> {
  __$$StockReservationImplCopyWithImpl(_$StockReservationImpl _value,
      $Res Function(_$StockReservationImpl) _then)
      : super(_value, _then);

  /// Create a copy of StockReservation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? quantity = null,
    Object? orderId = null,
    Object? status = null,
    Object? expiresAt = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$StockReservationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockReservationImpl implements _StockReservation {
  const _$StockReservationImpl(
      {required this.id,
      required this.productId,
      required this.quantity,
      required this.orderId,
      this.status = 'active',
      this.expiresAt,
      this.createdAt});

  factory _$StockReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockReservationImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final int quantity;
  @override
  final String orderId;
  @override
  @JsonKey()
  final String status;
// active | committed | released | expired
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'StockReservation(id: $id, productId: $productId, quantity: $quantity, orderId: $orderId, status: $status, expiresAt: $expiresAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, productId, quantity, orderId,
      status, expiresAt, createdAt);

  /// Create a copy of StockReservation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StockReservationImplCopyWith<_$StockReservationImpl> get copyWith =>
      __$$StockReservationImplCopyWithImpl<_$StockReservationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockReservationImplToJson(
      this,
    );
  }
}

abstract class _StockReservation implements StockReservation {
  const factory _StockReservation(
      {required final String id,
      required final String productId,
      required final int quantity,
      required final String orderId,
      final String status,
      final DateTime? expiresAt,
      final DateTime? createdAt}) = _$StockReservationImpl;

  factory _StockReservation.fromJson(Map<String, dynamic> json) =
      _$StockReservationImpl.fromJson;

  @override
  String get id;
  @override
  String get productId;
  @override
  int get quantity;
  @override
  String get orderId;
  @override
  String get status; // active | committed | released | expired
  @override
  DateTime? get expiresAt;
  @override
  DateTime? get createdAt;

  /// Create a copy of StockReservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockReservationImplCopyWith<_$StockReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
