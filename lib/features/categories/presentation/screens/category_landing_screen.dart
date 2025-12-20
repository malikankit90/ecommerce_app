import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/category_model.dart';
import '../providers/subcategories_provider.dart';
import '../../../home/presentation/widgets/category_section_row.dart';

class CategoryLandingScreen extends ConsumerWidget {
  final CategoryModel rootCategory;

  const CategoryLandingScreen({
    super.key,
    required this.rootCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subCategoriesAsync =
        ref.watch(subCategoriesProvider(rootCategory.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(rootCategory.name),
      ),
      body: subCategoriesAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            const Center(child: Text('Failed to load subcategories')),
        data: (subCategories) {
          if (subCategories.isEmpty) {
            return const Center(
              child: Text('No subcategories available'),
            );
          }

          return CategorySectionRow(
            rootCategory: rootCategory,
            subCategories: subCategories,
          );
        },
      ),
    );
  }
}
