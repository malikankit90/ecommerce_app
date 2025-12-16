import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import '../models/product_variant_model.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';


class ProductFirestoreService {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  // =====================================================
  // Products
  // =====================================================

  Future<void> createProduct(ProductModel product) async {
    await _products.doc(product.id).set(product.toFirestore());
  }

  Future<ProductModel?> getProductById(String productId) async {
    final doc = await _products.doc(productId).get();
    if (!doc.exists) return null;
    return ProductModel.fromFirestore(doc);
  }

  Stream<ProductModel?> getProductStream(String productId) {
    return _products.doc(productId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return ProductModel.fromFirestore(doc);
    });
  }

  Future<List<ProductModel>> getAllProducts({
    int? limit,
    String? status,
  }) async {
    Query<Map<String, dynamic>> query = _products;

    if (status != null) {
      query = query.where('status', isEqualTo: status);
    }

    query = query.where('isDeleted', isEqualTo: false);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();
  }

  Stream<List<ProductModel>> getProductsStream({
    int? limit,
    String? status,
    String? categoryId,
  }) {
    Query<Map<String, dynamic>> query = _products;

    if (status != null) {
      query = query.where('status', isEqualTo: status);
    }

    if (categoryId != null) {
      query = query.where('categoryId', isEqualTo: categoryId);
    }

    query = query.where('isDeleted', isEqualTo: false);

    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<List<ProductModel>> getFeaturedProducts({int limit = 10}) async {
    final snapshot = await _products
        .where('isFeatured', isEqualTo: true)
        .where('status', isEqualTo: 'active')
        .where('isDeleted', isEqualTo: false)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();
  }

  Future<List<ProductModel>> getNewArrivals({int limit = 10}) async {
    final snapshot = await _products
        .where('isNewArrival', isEqualTo: true)
        .where('status', isEqualTo: 'active')
        .where('isDeleted', isEqualTo: false)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final snapshot = await _products
        .where('status', isEqualTo: 'active')
        .where('isDeleted', isEqualTo: false)
        .where('searchKeywords', arrayContains: query.toLowerCase())
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();
  }

  Future<List<ProductModel>> getProductsByCategory(
    String categoryId, {
    int? limit,
  }) async {
    Query<Map<String, dynamic>> query = _products
        .where('categoryId', isEqualTo: categoryId)
        .where('status', isEqualTo: 'active')
        .where('isDeleted', isEqualTo: false);

    if (limit != null) {
      query = query.limit(limit);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc))
        .toList();
  }

  Future<void> updateProduct(
    String productId,
    Map<String, dynamic> data,
  ) async {
    await _products.doc(productId).update({
      ...data,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> incrementViewCount(String productId) async {
    await _products.doc(productId).update({
      'viewCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // =====================================================
  // Product Variants (subcollection)
  // =====================================================

  CollectionReference<Map<String, dynamic>> _variants(String productId) =>
      _products.doc(productId).collection('variants');

  Future<List<ProductVariantModel>> getProductVariants(
    String productId,
  ) async {
    final snapshot = await _variants(productId)
        .where('isDeleted', isEqualTo: false)
        .get();

    return snapshot.docs
        .map((doc) => ProductVariantModel.fromFirestore(doc))
        .toList();
  }

  Stream<List<ProductVariantModel>> getProductVariantsStream(
    String productId,
  ) {
    return _variants(productId)
        .where('isDeleted', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProductVariantModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<ProductVariantModel?> getVariantById(
    String productId,
    String variantId,
  ) async {
    final doc = await _variants(productId).doc(variantId).get();
    if (!doc.exists) return null;
    return ProductVariantModel.fromFirestore(doc);
  }
}