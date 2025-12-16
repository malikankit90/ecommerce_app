import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ecommerce_app/features/auth/presentation/providers/auth_providers.dart';

import '../../data/models/category_model.dart';
import '../../data/repositories/category_repository.dart';
import '../../data/services/category_firestore_service.dart';

/// =======================================================
/// Service Providers
/// =======================================================

final categoryFirestoreServiceProvider =
    Provider<CategoryFirestoreService>((ref) {
  return CategoryFirestoreService();
});

/// =======================================================
/// Repository Provider
/// =======================================================

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository(
    firestoreService: ref.read(categoryFirestoreServiceProvider),
  );
});

/// =======================================================
/// Categories Stream (All Active)
/// =======================================================

final categoriesStreamProvider =
    StreamProvider<List<CategoryModel>>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    loading: () => const Stream.empty(),
    error: (_, __) => const Stream.empty(),
    data: (user) {
      if (user == null) {
        return const Stream.empty();
      }

      return ref
          .read(categoryRepositoryProvider)
          .getCategoriesStream();
    },
  );
});

/// =======================================================
/// Root Categories (Level 0)
/// =======================================================

final rootCategoriesProvider =
    FutureProvider<List<CategoryModel>>((ref) async {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    loading: () async => [],
    error: (_, __) async => [],
    data: (user) async {
      if (user == null) return [];

      try {
        return await ref
            .read(categoryRepositoryProvider)
            .getRootCategories();
      } catch (e, st) {
        debugPrint('Root categories error: $e');
        debugPrintStack(stackTrace: st);
        rethrow;
      }
    },
  );
});

/// =======================================================
/// Featured Categories
/// =======================================================

final featuredCategoriesProvider =
    FutureProvider<List<CategoryModel>>((ref) async {
  final authState = ref.watch(authStateProvider);

  return authState.when(
    loading: () async => [],
    error: (_, __) async => [],
    data: (user) async {
      if (user == null) return [];

      try {
        return await ref
            .read(categoryRepositoryProvider)
            .getFeaturedCategories();
      } catch (e, st) {
        debugPrint('Featured categories error: $e');
        debugPrintStack(stackTrace: st);
        rethrow;
      }
    },
  );
});

/// =======================================================
/// Category by ID (Stream)
/// =======================================================

final categoryByIdProvider =
    StreamProvider.family<CategoryModel?, String>(
  (ref, categoryId) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () => const Stream.empty(),
      error: (_, __) => const Stream.empty(),
      data: (user) {
        if (user == null) {
          return const Stream.empty();
        }

        return ref
            .read(categoryRepositoryProvider)
            .getCategoryStream(categoryId);
      },
    );
  },
);

/// =======================================================
/// Subcategories by Parent ID
/// =======================================================

final subCategoriesProvider =
    FutureProvider.family<List<CategoryModel>, String>(
  (ref, parentId) async {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      loading: () async => [],
      error: (_, __) async => [],
      data: (user) async {
        if (user == null) return [];

        try {
          return await ref
              .read(categoryRepositoryProvider)
              .getSubCategories(parentId);
        } catch (e, st) {
          debugPrint('Subcategories error: $e');
          debugPrintStack(stackTrace: st);
          rethrow;
        }
      },
    );
  },
);

/// =======================================================
/// Category Controller
/// =======================================================

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, AsyncValue<void>>((ref) {
  return CategoryController(
    categoryRepository: ref.read(categoryRepositoryProvider),
  );
});

class CategoryController extends StateNotifier<AsyncValue<void>> {
  final CategoryRepository _categoryRepository;

  CategoryController({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const AsyncValue.data(null));

  /// ---------------------------------------------------
  /// Create category (admin feature)
  /// ---------------------------------------------------
  Future<void> createCategory(CategoryModel category) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _categoryRepository.createCategory(category);
    });
  }

  /// ---------------------------------------------------
  /// Update category (admin feature)
  /// ---------------------------------------------------
  Future<void> updateCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _categoryRepository.updateCategory(categoryId, data);
    });
  }
}
