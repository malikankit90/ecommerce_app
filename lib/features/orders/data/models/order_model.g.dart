// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemModelImpl _$$OrderItemModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemModelImpl(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productSlug: json['productSlug'] as String,
      brandName: json['brandName'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      variantId: json['variantId'] as String?,
      size: json['size'] as String?,
      color: json['color'] as String?,
    );

Map<String, dynamic> _$$OrderItemModelImplToJson(
        _$OrderItemModelImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'productSlug': instance.productSlug,
      'brandName': instance.brandName,
      'thumbnailUrl': instance.thumbnailUrl,
      'price': instance.price,
      'quantity': instance.quantity,
      'variantId': instance.variantId,
      'size': instance.size,
      'color': instance.color,
    };

_$ShippingAddressModelImpl _$$ShippingAddressModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ShippingAddressModelImpl(
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$$ShippingAddressModelImplToJson(
        _$ShippingAddressModelImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
      'postalCode': instance.postalCode,
      'country': instance.country,
    };
