// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImageImpl _$$ProductImageImplFromJson(Map<String, dynamic> json) =>
    _$ProductImageImpl(
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      sortOrder: (json['sortOrder'] as num).toInt(),
      altText: json['altText'] as String?,
      isPrimary: json['isPrimary'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductImageImplToJson(_$ProductImageImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'sortOrder': instance.sortOrder,
      'altText': instance.altText,
      'isPrimary': instance.isPrimary,
    };

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: json['id'] as String,
      sku: json['sku'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String?,
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      categoryPath: (json['categoryPath'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      subCategoryId: json['subCategoryId'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      basePrice: (json['basePrice'] as num).toDouble(),
      sellingPrice: (json['sellingPrice'] as num).toDouble(),
      compareAtPrice: (json['compareAtPrice'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toInt() ?? 0,
      currency: json['currency'] as String? ?? 'USD',
      costPrice: (json['costPrice'] as num?)?.toDouble(),
      totalStock: (json['totalStock'] as num?)?.toInt() ?? 0,
      reservedStock: (json['reservedStock'] as num?)?.toInt() ?? 0,
      availableStock: (json['availableStock'] as num?)?.toInt() ?? 0,
      inStock: json['inStock'] as bool? ?? false,
      stockStatus: json['stockStatus'] as String? ?? 'out_of_stock',
      lowStockThreshold: (json['lowStockThreshold'] as num?)?.toInt() ?? 10,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ProductImage>[],
      thumbnailUrl: json['thumbnailUrl'] as String,
      videoUrl: json['videoUrl'] as String?,
      video360Url: json['video360Url'] as String?,
      material: json['material'] as String? ?? '',
      careInstructions: json['careInstructions'] as String? ?? '',
      fit: json['fit'] as String? ?? 'regular',
      origin: json['origin'] as String? ?? '',
      specifications: (json['specifications'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      metaTitle: json['metaTitle'] as String? ?? '',
      metaDescription: json['metaDescription'] as String? ?? '',
      searchKeywords: (json['searchKeywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      status: json['status'] as String? ?? 'draft',
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNewArrival: json['isNewArrival'] as bool? ?? false,
      isBestseller: json['isBestseller'] as bool? ?? false,
      isSale: json['isSale'] as bool? ?? false,
      isExclusive: json['isExclusive'] as bool? ?? false,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
      ratingDistribution:
          (json['ratingDistribution'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
              ) ??
              const <int, int>{},
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      addToCartCount: (json['addToCartCount'] as num?)?.toInt() ?? 0,
      purchaseCount: (json['purchaseCount'] as num?)?.toInt() ?? 0,
      wishlistCount: (json['wishlistCount'] as num?)?.toInt() ?? 0,
      conversionRate: (json['conversionRate'] as num?)?.toDouble() ?? 0.0,
      popularityScore: (json['popularityScore'] as num?)?.toDouble() ?? 0.0,
      vendorId: json['vendorId'] as String?,
      vendorName: json['vendorName'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      dimensions: (json['dimensions'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const <String, double>{},
      freeShipping: json['freeShipping'] as bool? ?? false,
      shippingMethods: (json['shippingMethods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      publishedAt: const TimestampConverter().fromJson(json['publishedAt']),
      deletedAt: const TimestampConverter().fromJson(json['deletedAt']),
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'brandId': instance.brandId,
      'brandName': instance.brandName,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'categoryPath': instance.categoryPath,
      'subCategoryId': instance.subCategoryId,
      'tags': instance.tags,
      'basePrice': instance.basePrice,
      'sellingPrice': instance.sellingPrice,
      'compareAtPrice': instance.compareAtPrice,
      'discountPercentage': instance.discountPercentage,
      'currency': instance.currency,
      'costPrice': instance.costPrice,
      'totalStock': instance.totalStock,
      'reservedStock': instance.reservedStock,
      'availableStock': instance.availableStock,
      'inStock': instance.inStock,
      'stockStatus': instance.stockStatus,
      'lowStockThreshold': instance.lowStockThreshold,
      'images': instance.images,
      'thumbnailUrl': instance.thumbnailUrl,
      'videoUrl': instance.videoUrl,
      'video360Url': instance.video360Url,
      'material': instance.material,
      'careInstructions': instance.careInstructions,
      'fit': instance.fit,
      'origin': instance.origin,
      'specifications': instance.specifications,
      'metaTitle': instance.metaTitle,
      'metaDescription': instance.metaDescription,
      'searchKeywords': instance.searchKeywords,
      'status': instance.status,
      'isFeatured': instance.isFeatured,
      'isNewArrival': instance.isNewArrival,
      'isBestseller': instance.isBestseller,
      'isSale': instance.isSale,
      'isExclusive': instance.isExclusive,
      'averageRating': instance.averageRating,
      'totalReviews': instance.totalReviews,
      'ratingDistribution':
          instance.ratingDistribution.map((k, e) => MapEntry(k.toString(), e)),
      'viewCount': instance.viewCount,
      'addToCartCount': instance.addToCartCount,
      'purchaseCount': instance.purchaseCount,
      'wishlistCount': instance.wishlistCount,
      'conversionRate': instance.conversionRate,
      'popularityScore': instance.popularityScore,
      'vendorId': instance.vendorId,
      'vendorName': instance.vendorName,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'freeShipping': instance.freeShipping,
      'shippingMethods': instance.shippingMethods,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'publishedAt': const TimestampConverter().toJson(instance.publishedAt),
      'deletedAt': const TimestampConverter().toJson(instance.deletedAt),
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'isDeleted': instance.isDeleted,
    };
