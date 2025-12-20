import 'package:flutter/material.dart';
import '../../../categories/data/models/category_model.dart';
import '../../../categories/presentation/widgets/category_icon_item.dart';
import 'section_header.dart';

class CategorySectionRow extends StatelessWidget {
  final CategoryModel rootCategory;
  final List<CategoryModel> subCategories;

  const CategorySectionRow({
    super.key,
    required this.rootCategory,
    required this.subCategories,
  });

  @override
  Widget build(BuildContext context) {
    if (subCategories.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: rootCategory.name),

        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: subCategories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, index) {
              return CategoryIconItem(
                category: subCategories[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
