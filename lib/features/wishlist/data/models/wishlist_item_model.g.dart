// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WishlistItemModelImpl _$$WishlistItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WishlistItemModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productSlug: json['productSlug'] as String,
      brandName: json['brandName'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      price: (json['price'] as num).toDouble(),
      compareAtPrice: (json['compareAtPrice'] as num?)?.toDouble(),
      inStock: json['inStock'] as bool,
      availableStock: (json['availableStock'] as num).toInt(),
      addedAt: const TimestampConverter().fromJson(json['addedAt']),
    );

Map<String, dynamic> _$$WishlistItemModelImplToJson(
        _$WishlistItemModelImpl instance) =>
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
      'inStock': instance.inStock,
      'availableStock': instance.availableStock,
      'addedAt': const TimestampConverter().toJson(instance.addedAt),
    };
