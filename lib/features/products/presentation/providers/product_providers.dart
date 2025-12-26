import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import '../../data/models/product_variant_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/services/product_firestore_service.dart';

/// =======================================================
/// Firestore Service Provider
/// =======================================================

final productFirestoreServiceProvider =
    Provider<ProductFirestoreService>((ref) {
  return ProductFirestoreService();
});

/// =======================================================
/// Repository Provider
/// =======================================================

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(
    firestoreService: ref.read(productFirestoreServiceProvider),
  );
});

/// =======================================================
/// Products Stream (All Active Products)
/// =======================================================

final productsStreamProvider = StreamProvider<List<ProductModel>>((ref) async* {
  final authState = ref.watch(authStateProvider);

  yield* ref.read(productRepositoryProvider).getProductsStream(
        status: 'active',
      );
});

/// =======================================================
/// Featured Products
/// =======================================================

final featuredProductsProvider =
    FutureProvider<List<ProductModel>>((ref) async {
  final authState = ref.watch(authStateProvider);

  return ref.read(productRepositoryProvider).getFeaturedProducts();
});

/// =======================================================
/// New Arrivals
/// =======================================================

final newArrivalsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final authState = ref.watch(authStateProvider);

  return ref.read(productRepositoryProvider).getNewArrivals();
});

/// =======================================================
/// Product by ID (Stream)
/// =======================================================

final productByIdProvider = StreamProvider.family<ProductModel?, String>(
  (ref, productId) async* {
    final authState = ref.watch(authStateProvider);

    yield* ref.read(productRepositoryProvider).getProductStream(productId);
  },
);

/// =======================================================
/// Product Variants by Product ID
/// =======================================================

final productVariantsProvider =
    StreamProvider.family<List<ProductVariantModel>, String>(
  (ref, productId) async* {
    final authState = ref.watch(authStateProvider);

    yield* ref
        .read(productRepositoryProvider)
        .getProductVariantsStream(productId);
  },
);

/// =======================================================
/// ✅ PRODUCTS BY CATEGORY (BUG FIXED, API-SAFE)
/// =======================================================
/// - Uses EXISTING repository APIs only
/// - Prevents stale category reuse
/// - Single source of truth for ProductListScreen
/// =======================================================

final productsByCategoryProvider =
    FutureProvider.family<List<ProductModel>, String?>(
  (ref, categoryId) async {
    final authState = ref.watch(authStateProvider);

    final repository = ref.read(productRepositoryProvider);

    // ✅ No category → get ALL active products (via existing stream API)
    if (categoryId == null || categoryId.isEmpty) {
      final stream = repository.getProductsStream(status: 'active');
      return await stream.first;
    }

    // ✅ Category-specific products
    return repository.getProductsByCategory(categoryId);
  },
);

/// =======================================================
/// Search Products
/// =======================================================

final searchProductsProvider =
    FutureProvider.family<List<ProductModel>, String>(
  (ref, query) async {
    final authState = ref.watch(authStateProvider);

    if (query.trim().isEmpty) {
      return [];
    }

    return ref.read(productRepositoryProvider).searchProducts(query);
  },
);

/// =======================================================
/// Product Controller (Actions / Admin)
/// =======================================================

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<void>>((ref) {
  return ProductController(
    productRepository: ref.read(productRepositoryProvider),
  );
});

class ProductController extends StateNotifier<AsyncValue<void>> {
  final ProductRepository _productRepository;

  ProductController({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(const AsyncValue.data(null));

  /// ---------------------------------------------------
  /// Increment view count (analytics)
  /// ---------------------------------------------------
  Future<void> incrementViewCount(String productId) async {
    await _productRepository.incrementViewCount(productId);
  }

  /// ---------------------------------------------------
  /// Create product (admin)
  /// ---------------------------------------------------
  Future<void> createProduct(ProductModel product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _productRepository.createProduct(product);
    });
  }

  /// ---------------------------------------------------
  /// Update product (admin)
  /// ---------------------------------------------------
  Future<void> updateProduct(
    String productId,
    Map<String, dynamic> data,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _productRepository.updateProduct(productId, data);
    });
  }
}
