// lib/features/home/data/models/home_state.dart

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
}
