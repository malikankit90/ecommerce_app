// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockReservationImpl _$$StockReservationImplFromJson(
        Map<String, dynamic> json) =>
    _$StockReservationImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      orderId: json['orderId'] as String,
      status: json['status'] as String? ?? 'active',
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$StockReservationImplToJson(
        _$StockReservationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'orderId': instance.orderId,
      'status': instance.status,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
