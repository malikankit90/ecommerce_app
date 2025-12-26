// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemModelImpl _$$CartItemModelImplFromJson(Map<String, dynamic> json) =>
    _$CartItemModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productSlug: json['productSlug'] as String,
      brandName: json['brandName'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      price: (json['price'] as num).toDouble(),
      compareAtPrice: (json['compareAtPrice'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      variantId: json['variantId'] as String?,
      size: json['size'] as String?,
      color: json['color'] as String?,
      colorHex: json['colorHex'] as String?,
      addedAt: const TimestampConverter().fromJson(json['addedAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$CartItemModelImplToJson(_$CartItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'productId': instance.productId,
      'productName': instance.productName,
      'productSlug': instance.productSlug,
      'brandName': instance.brandName,
      'thumbnailUrl': instance.thumbnailUrl,
      'price': instance.price,
      'compareAtPrice': instance.compareAtPrice,
      'quantity': instance.quantity,
      'variantId': instance.variantId,
      'size': instance.size,
      'color': instance.color,
      'colorHex': instance.colorHex,
      'addedAt': const TimestampConverter().toJson(instance.addedAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
