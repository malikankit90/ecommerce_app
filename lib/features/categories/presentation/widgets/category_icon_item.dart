import 'package:flutter/material.dart';
import '../../../categories/data/models/category_model.dart';

class CategoryIconItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback? onTap;

  const CategoryIconItem({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade800,
            child: const Icon(
              Icons.category, // can be replaced later with category.icon
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.name,
            style: Theme.of(context).textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
