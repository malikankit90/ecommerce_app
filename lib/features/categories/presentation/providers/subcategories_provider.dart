import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/category_model.dart';
import 'category_providers.dart'; // 👈 REQUIRED IMPORT

final subCategoriesProvider =
    FutureProvider.family<List<CategoryModel>, String>(
  (ref, parentCategoryId) async {
    final repo = ref.read(categoryRepositoryProvider);
    return repo.getSubCategories(parentCategoryId);
  },
);
