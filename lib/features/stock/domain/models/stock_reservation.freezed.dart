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
  /// Firestore document ID
  String get id => throw _privateConstructorUsedError;

  /// Ownership
  String get orderId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  /// All reserved items (atomic unit)
  List<ReservedItem> get items => throw _privateConstructorUsedError;

  /// active | committed | released | expired
  String get status => throw _privateConstructorUsedError;

  /// Hard TTL – must be enforced by backend cleanup
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Audit
  DateTime get createdAt => throw _privateConstructorUsedError;

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
      String orderId,
      String userId,
      List<ReservedItem> items,
      String status,
      DateTime expiresAt,
      DateTime createdAt});
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
    Object? orderId = null,
    Object? userId = null,
    Object? items = null,
    Object? status = null,
    Object? expiresAt = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReservedItem>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      String orderId,
      String userId,
      List<ReservedItem> items,
      String status,
      DateTime expiresAt,
      DateTime createdAt});
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
    Object? orderId = null,
    Object? userId = null,
    Object? items = null,
    Object? status = null,
    Object? expiresAt = null,
    Object? createdAt = null,
  }) {
    return _then(_$StockReservationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReservedItem>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockReservationImpl extends _StockReservation {
  const _$StockReservationImpl(
      {required this.id,
      required this.orderId,
      required this.userId,
      required final List<ReservedItem> items,
      this.status = 'active',
      required this.expiresAt,
      required this.createdAt})
      : _items = items,
        super._();

  factory _$StockReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockReservationImplFromJson(json);

  /// Firestore document ID
  @override
  final String id;

  /// Ownership
  @override
  final String orderId;
  @override
  final String userId;

  /// All reserved items (atomic unit)
  final List<ReservedItem> _items;

  /// All reserved items (atomic unit)
  @override
  List<ReservedItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// active | committed | released | expired
  @override
  @JsonKey()
  final String status;

  /// Hard TTL – must be enforced by backend cleanup
  @override
  final DateTime expiresAt;

  /// Audit
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'StockReservation(id: $id, orderId: $orderId, userId: $userId, items: $items, status: $status, expiresAt: $expiresAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderId,
      userId,
      const DeepCollectionEquality().hash(_items),
      status,
      expiresAt,
      createdAt);

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

abstract class _StockReservation extends StockReservation {
  const factory _StockReservation(
      {required final String id,
      required final String orderId,
      required final String userId,
      required final List<ReservedItem> items,
      final String status,
      required final DateTime expiresAt,
      required final DateTime createdAt}) = _$StockReservationImpl;
  const _StockReservation._() : super._();

  factory _StockReservation.fromJson(Map<String, dynamic> json) =
      _$StockReservationImpl.fromJson;

  /// Firestore document ID
  @override
  String get id;

  /// Ownership
  @override
  String get orderId;
  @override
  String get userId;

  /// All reserved items (atomic unit)
  @override
  List<ReservedItem> get items;

  /// active | committed | released | expired
  @override
  String get status;

  /// Hard TTL – must be enforced by backend cleanup
  @override
  DateTime get expiresAt;

  /// Audit
  @override
  DateTime get createdAt;

  /// Create a copy of StockReservation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StockReservationImplCopyWith<_$StockReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
