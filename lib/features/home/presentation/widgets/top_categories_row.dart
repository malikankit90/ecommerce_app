import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../categories/data/models/category_model.dart';
import '../providers/home_ui_state_provider.dart';

class TopCategoriesRow extends ConsumerWidget {
  final List<CategoryModel> categories;

  const TopCategoriesRow({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectedRootCategoryIdProvider);

    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, index) {
          final category = categories[index];
          final isSelected = category.id == selectedId;

          return GestureDetector(
            onTap: () {
              final notifier = ref.read(
                selectedRootCategoryIdProvider.notifier,
              );

              // 🔥 Toggle logic
              notifier.state = isSelected ? null : category.id;
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade200,
                  child: Text(
                    category.name.characters.first,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  category.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
