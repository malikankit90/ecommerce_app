// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductVariantModelImpl _$$ProductVariantModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductVariantModelImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      sku: json['sku'] as String,
      size: json['size'] as String,
      sizeLabel: json['sizeLabel'] as String?,
      color: json['color'] as String,
      colorHex: json['colorHex'] as String,
      colorFamily: json['colorFamily'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      compareAtPrice: (json['compareAtPrice'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      reservedStock: (json['reservedStock'] as num?)?.toInt() ?? 0,
      availableStock: (json['availableStock'] as num?)?.toInt() ?? 0,
      inStock: json['inStock'] as bool? ?? false,
      warehouseLocation: json['warehouseLocation'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      barcode: json['barcode'] as String?,
      ean: json['ean'] as String?,
      upc: json['upc'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$ProductVariantModelImplToJson(
        _$ProductVariantModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'sku': instance.sku,
      'size': instance.size,
      'sizeLabel': instance.sizeLabel,
      'color': instance.color,
      'colorHex': instance.colorHex,
      'colorFamily': instance.colorFamily,
      'price': instance.price,
      'compareAtPrice': instance.compareAtPrice,
      'stock': instance.stock,
      'reservedStock': instance.reservedStock,
      'availableStock': instance.availableStock,
      'inStock': instance.inStock,
      'warehouseLocation': instance.warehouseLocation,
      'imageUrls': instance.imageUrls,
      'barcode': instance.barcode,
      'ean': instance.ean,
      'upc': instance.upc,
      'isActive': instance.isActive,
      'isDeleted': instance.isDeleted,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
