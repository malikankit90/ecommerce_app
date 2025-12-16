import '../models/category_model.dart';
import '../services/category_firestore_service.dart';

class CategoryRepository {
  final CategoryFirestoreService _firestoreService;

  CategoryRepository({
    required CategoryFirestoreService firestoreService,
  }) : _firestoreService = firestoreService;

  // =====================================================
  // Categories - Read
  // =====================================================

  Future<CategoryModel?> getCategoryById(String categoryId) async {
    try {
      return await _firestoreService.getCategoryById(categoryId);
    } catch (e) {
      throw Exception('Failed to get category: $e');
    }
  }

  Stream<CategoryModel?> getCategoryStream(String categoryId) {
    try {
      return _firestoreService.getCategoryStream(categoryId);
    } catch (e) {
      throw Exception('Failed to stream category: $e');
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      return await _firestoreService.getAllCategories();
    } catch (e) {
      throw Exception('Failed to get all categories: $e');
    }
  }

  Stream<List<CategoryModel>> getCategoriesStream() {
    try {
      return _firestoreService.getCategoriesStream();
    } catch (e) {
      throw Exception('Failed to stream categories: $e');
    }
  }

  Future<List<CategoryModel>> getRootCategories() async {
    try {
      return await _firestoreService.getRootCategories();
    } catch (e) {
      throw Exception('Failed to get root categories: $e');
    }
  }

  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    try {
      return await _firestoreService.getSubCategories(parentId);
    } catch (e) {
      throw Exception('Failed to get subcategories: $e');
    }
  }

  Future<List<CategoryModel>> getFeaturedCategories() async {
    try {
      return await _firestoreService.getFeaturedCategories();
    } catch (e) {
      throw Exception('Failed to get featured categories: $e');
    }
  }

  // =====================================================
  // Categories - Write
  // =====================================================

  Future<void> createCategory(CategoryModel category) async {
    try {
      await _firestoreService.createCategory(category);
    } catch (e) {
      throw Exception('Failed to create category: $e');
    }
  }

  Future<void> updateCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestoreService.updateCategory(categoryId, data);
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }
}