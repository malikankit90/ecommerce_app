// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockReservationImpl _$$StockReservationImplFromJson(
        Map<String, dynamic> json) =>
    _$StockReservationImpl(
      id: json['id'] as String,
      orderId: json['orderId'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => ReservedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String? ?? 'active',
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$StockReservationImplToJson(
        _$StockReservationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'userId': instance.userId,
      'items': instance.items,
      'status': instance.status,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };
