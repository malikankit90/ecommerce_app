import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/category_model.dart';
import '../../data/repositories/category_repository.dart';
import '../../data/services/category_firestore_service.dart';

/// =======================================================
/// FIRESTORE SERVICE PROVIDER
/// =======================================================

final categoryFirestoreServiceProvider =
    Provider<CategoryFirestoreService>((ref) {
  return CategoryFirestoreService();
});

/// =======================================================
/// CATEGORY REPOSITORY PROVIDER
/// =======================================================

final categoryRepositoryProvider =
    Provider<CategoryRepository>((ref) {
  return CategoryRepository(
    firestoreService:
        ref.read(categoryFirestoreServiceProvider),
  );
});

/// =======================================================
/// ALL CATEGORIES (STREAM — READ ONLY, NO AUTH COUPLING)
/// =======================================================

final categoriesStreamProvider =
    StreamProvider<List<CategoryModel>>((ref) {
  return ref
      .read(categoryRepositoryProvider)
      .getCategoriesStream();
});

/// =======================================================
/// ROOT CATEGORIES (LEVEL 0)
/// =======================================================

final rootCategoriesProvider =
    FutureProvider<List<CategoryModel>>((ref) async {
  try {
    return await ref
        .read(categoryRepositoryProvider)
        .getRootCategories();
  } catch (e, st) {
    debugPrint('Root categories error: $e');
    debugPrintStack(stackTrace: st);
    return [];
  }
});

/// =======================================================
/// SUBCATEGORIES BY PARENT ID
/// =======================================================

final subCategoriesProvider =
    FutureProvider.family<List<CategoryModel>, String>(
  (ref, parentId) async {
    try {
      return await ref
          .read(categoryRepositoryProvider)
          .getSubCategories(parentId);
    } catch (e, st) {
      debugPrint('Subcategories error: $e');
      debugPrintStack(stackTrace: st);
      return [];
    }
  },
);

/// =======================================================
/// CATEGORY BY ID (STREAM)
/// =======================================================

final categoryByIdProvider =
    StreamProvider.family<CategoryModel?, String>(
  (ref, categoryId) {
    return ref
        .read(categoryRepositoryProvider)
        .getCategoryStream(categoryId);
  },
);

/// =======================================================
/// FEATURED CATEGORIES
/// =======================================================

final featuredCategoriesProvider =
    FutureProvider<List<CategoryModel>>((ref) async {
  try {
    return await ref
        .read(categoryRepositoryProvider)
        .getFeaturedCategories();
  } catch (e, st) {
    debugPrint('Featured categories error: $e');
    debugPrintStack(stackTrace: st);
    return [];
  }
});

/// =======================================================
/// CATEGORY CONTROLLER (ADMIN ONLY)
/// =======================================================

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, AsyncValue<void>>(
  (ref) {
    return CategoryController(
      categoryRepository:
          ref.read(categoryRepositoryProvider),
    );
  },
);

class CategoryController extends StateNotifier<AsyncValue<void>> {
  final CategoryRepository _categoryRepository;

  CategoryController({
    required CategoryRepository categoryRepository,
  })  : _categoryRepository = categoryRepository,
        super(const AsyncValue.data(null));

  /// ---------------------------------------------------
  /// CREATE CATEGORY (ADMIN)
  /// ---------------------------------------------------
  Future<void> createCategory(CategoryModel category) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _categoryRepository.createCategory(category);
    });
  }

  /// ---------------------------------------------------
  /// UPDATE CATEGORY (ADMIN)
  /// ---------------------------------------------------
  Future<void> updateCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await _categoryRepository.updateCategory(
        categoryId,
        data,
      );
    });
  }
}
