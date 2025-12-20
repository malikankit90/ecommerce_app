import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../categories/data/models/category_model.dart';

class TopCategoriesRow extends StatelessWidget {
  final List<CategoryModel> categories;

  const TopCategoriesRow({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: categories.take(4).map((category) {
          return InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {
              // ✅ ROOT CATEGORY → CATEGORY LANDING
              context.push(
                '/category',
                extra: category,
              );
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  child: Text(
                    category.name.characters.first,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  category.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
