// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserved_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservedItemImpl _$$ReservedItemImplFromJson(Map<String, dynamic> json) =>
    _$ReservedItemImpl(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$ReservedItemImplToJson(_$ReservedItemImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
