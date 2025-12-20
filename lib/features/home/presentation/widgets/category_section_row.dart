import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../categories/data/models/category_model.dart';

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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            rootCategory.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: subCategories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              final category = subCategories[index];

              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  context.push(
                    '/products',
                    extra: {
                      'categoryId': category.id,
                      'title': category.name,
                    },
                  );
                },
                child: SizedBox(
                  width: 72,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: category.imageUrl.isNotEmpty
                            ? NetworkImage(category.imageUrl)
                            : null,
                        child: category.imageUrl.isEmpty
                            ? const Icon(
                                Icons.image,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        category.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
