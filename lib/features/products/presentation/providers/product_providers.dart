import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import '../../data/models/product_variant_model.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/services/product_firestore_service.dart';

/// =======================================================
/// Service Providers
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

final productsStreamProvider =
    StreamProvider<List<ProductModel>>((ref) async* {
  final authState = ref.watch(authStateProvider);

  if (authState == null) {
    yield [];
    return;
  }

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

  if (authState == null) {
    return [];
  }

  return ref.read(productRepositoryProvider).getFeaturedProducts();
});

/// =======================================================
/// New Arrivals
/// =======================================================

final newArrivalsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final authState = ref.watch(authStateProvider);

  if (authState == null) {
    return [];
  }

  return ref.read(productRepositoryProvider).getNewArrivals();
});

/// =======================================================
/// Product by ID (Stream)
/// =======================================================

final productByIdProvider =
    StreamProvider.family<ProductModel?, String>(
  (ref, productId) async* {
    final authState = ref.watch(authStateProvider);

    if (authState == null) {
      yield null;
      return;
    }

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

    if (authState == null) {
      yield [];
      return;
    }

    yield* ref
        .read(productRepositoryProvider)
        .getProductVariantsStream(productId);
  },
);

/// =======================================================
/// Products by Category
/// =======================================================

final productsByCategoryProvider =
    FutureProvider.family<List<ProductModel>, String>(
  (ref, categoryId) async {
    final authState = ref.watch(authStateProvider);

    if (authState == null) {
      return [];
    }

    return ref.read(productRepositoryProvider)
        .getProductsByCategory(categoryId);
  },
);

/// =======================================================
/// Search Products
/// =======================================================

final searchProductsProvider =
    FutureProvider.family<List<ProductModel>, String>(
  (ref, query) async {
    final authState = ref.watch(authStateProvider);

    if (authState == null || query.trim().isEmpty) {
      return [];
    }

    return ref.read(productRepositoryProvider).searchProducts(query);
  },
);

/// =======================================================
/// Product Controller (for actions)
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
  /// Create product (admin feature)
  /// ---------------------------------------------------
  Future<void> createProduct(ProductModel product) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _productRepository.createProduct(product);
    });
  }

  /// ---------------------------------------------------
  /// Update product (admin feature)
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
