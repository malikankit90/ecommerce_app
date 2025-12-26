import '../models/product_model.dart';
import '../models/product_variant_model.dart';
import '../services/product_firestore_service.dart';

class ProductRepository {
  final ProductFirestoreService _firestoreService;

  ProductRepository({
    required ProductFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  // =====================================================
  // Products - READ ONLY (NO STOCK MUTATION)
  // =====================================================

  Future<ProductModel?> getProductById(String productId) async {
    try {
      return await _firestoreService.getProductById(productId);
    } catch (e) {
      throw Exception('Failed to get product: $e');
    }
  }

  Stream<ProductModel?> getProductStream(String productId) {
    try {
      return _firestoreService.getProductStream(productId);
    } catch (e) {
      throw Exception('Failed to stream product: $e');
    }
  }

  Future<List<ProductModel>> getAllProducts({
    int? limit,
    String? status,
  }) async {
    try {
      return await _firestoreService.getAllProducts(
        limit: limit,
        status: status,
      );
    } catch (e) {
      throw Exception('Failed to get all products: $e');
    }
  }

  Stream<List<ProductModel>> getProductsStream({
    int? limit,
    String? status,
    String? categoryId,
  }) {
    try {
      return _firestoreService.getProductsStream(
        limit: limit,
        status: status,
        categoryId: categoryId,
      );
    } catch (e) {
      throw Exception('Failed to stream products: $e');
    }
  }

  Future<List<ProductModel>> getFeaturedProducts({
    int limit = 10,
  }) async {
    try {
      return await _firestoreService.getFeaturedProducts(limit: limit);
    } catch (e) {
      throw Exception('Failed to get featured products: $e');
    }
  }

  Future<List<ProductModel>> getNewArrivals({
    int limit = 10,
  }) async {
    try {
      return await _firestoreService.getNewArrivals(limit: limit);
    } catch (e) {
      throw Exception('Failed to get new arrivals: $e');
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      if (query.trim().isEmpty) return [];
      return await _firestoreService.searchProducts(query);
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(
    String categoryId, {
    int? limit,
  }) async {
    try {
      return await _firestoreService.getProductsByCategory(
        categoryId,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Failed to get products by category: $e');
    }
  }

  // =====================================================
  // Products - WRITE (METADATA ONLY)
  // ⚠️ NEVER TOUCH STOCK HERE
  // =====================================================

  Future<void> createProduct(ProductModel product) async {
    try {
      await _firestoreService.createProduct(product);
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  Future<void> updateProduct(
    String productId,
    Map<String, dynamic> data,
  ) async {
    try {
      // 🚨 SAFETY GUARD: prevent accidental stock mutation
      data.remove('totalStock');
      data.remove('reservedStock');

      await _firestoreService.updateProduct(productId, data);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  Future<void> incrementViewCount(String productId) async {
    try {
      await _firestoreService.incrementViewCount(productId);
    } catch (_) {
      // Silent fail for analytics
    }
  }

  // =====================================================
  // Product Variants (READ ONLY)
  // =====================================================

  Future<List<ProductVariantModel>> getProductVariants(
    String productId,
  ) async {
    try {
      return await _firestoreService.getProductVariants(productId);
    } catch (e) {
      throw Exception('Failed to get product variants: $e');
    }
  }

  Stream<List<ProductVariantModel>> getProductVariantsStream(
    String productId,
  ) {
    try {
      return _firestoreService.getProductVariantsStream(productId);
    } catch (e) {
      throw Exception('Failed to stream product variants: $e');
    }
  }

  Future<ProductVariantModel?> getVariantById(
    String productId,
    String variantId,
  ) async {
    try {
      return await _firestoreService.getVariantById(productId, variantId);
    } catch (e) {
      throw Exception('Failed to get variant: $e');
    }
  }
}
