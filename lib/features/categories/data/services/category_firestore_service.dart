import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category_model.dart';

class CategoryFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _categories =>
      _firestore.collection('categories');

  // =====================================================
  // CREATE
  // =====================================================

  Future<void> createCategory(CategoryModel category) async {
    await _categories.doc(category.id).set(category.toFirestore());
  }

  // =====================================================
  // READ — SINGLE
  // =====================================================

  Future<CategoryModel?> getCategoryById(String categoryId) async {
    final doc = await _categories.doc(categoryId).get();
    if (!doc.exists || doc.data() == null) return null;
    return CategoryModel.fromFirestore(doc);
  }

  Stream<CategoryModel?> getCategoryStream(String categoryId) {
    return _categories.doc(categoryId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return CategoryModel.fromFirestore(doc);
    });
  }

  // =====================================================
  // READ — LIST
  // =====================================================

  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await _categories
        .where('isDeleted', isEqualTo: false)
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs
        .map((doc) => CategoryModel.fromFirestore(doc))
        .toList();
  }

  Stream<List<CategoryModel>> getCategoriesStream() {
    return _categories
        .where('isDeleted', isEqualTo: false)
        .where('isActive', isEqualTo: true)
        .orderBy('sortOrder')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => CategoryModel.fromFirestore(doc))
          .toList();
    });
  }

  // =====================================================
  // HIERARCHY
  // =====================================================

  Future<List<CategoryModel>> getRootCategories() async {
    final snapshot = await _categories
        .where('isDeleted', isEqualTo: false)
        .where('isActive', isEqualTo: true)
        .where('level', isEqualTo: 0)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs
        .map((doc) => CategoryModel.fromFirestore(doc))
        .toList();
  }

  Future<List<CategoryModel>> getSubCategories(String parentId) async {
    final snapshot = await _categories
        .where('isDeleted', isEqualTo: false)
        .where('isActive', isEqualTo: true)
        .where('parentCategoryId', isEqualTo: parentId)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs
        .map((doc) => CategoryModel.fromFirestore(doc))
        .toList();
  }

  // =====================================================
  // FEATURED
  // =====================================================

  Future<List<CategoryModel>> getFeaturedCategories() async {
    final snapshot = await _categories
        .where('isDeleted', isEqualTo: false)
        .where('isActive', isEqualTo: true)
        .where('isFeatured', isEqualTo: true)
        .orderBy('sortOrder')
        .get();

    return snapshot.docs
        .map((doc) => CategoryModel.fromFirestore(doc))
        .toList();
  }

  // =====================================================
  // UPDATE
  // =====================================================

  Future<void> updateCategory(
    String categoryId,
    Map<String, dynamic> data,
  ) async {
    await _categories.doc(categoryId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
