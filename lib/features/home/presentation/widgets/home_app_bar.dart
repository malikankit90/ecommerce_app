import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'cart_icon.dart';
import 'wishlist_icon.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('ECommerce'),
      actions: [
        WishlistIcon(),
        CartIcon(),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.push('/search');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
