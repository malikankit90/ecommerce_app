import '../../../products/data/models/product_model.dart';
import '../../../categories/data/models/category_model.dart';

class HomeState {
  final List<ProductModel> trending;
  final List<ProductModel> recommended;
  final List<CategoryModel> categories;

  const HomeState({
    required this.trending,
    required this.recommended,
    required this.categories,
  });

  /// ROOT CATEGORIES → Men / Women / Kids
  List<CategoryModel> get rootCategories {
    return categories
        .where(
          (c) => c.parentCategoryId == null && c.isAvailable,
        )
        .toList()
      ..sort(
        (a, b) => a.sortOrder.compareTo(b.sortOrder),
      );
  }

  /// SUBCATEGORIES UNDER A ROOT
  List<CategoryModel> subCategoriesOf(String parentId) {
    return categories
        .where(
          (c) =>
              c.parentCategoryId == parentId &&
              c.isAvailable,
        )
        .toList()
      ..sort(
        (a, b) => a.sortOrder.compareTo(b.sortOrder),
      );
  }
}
