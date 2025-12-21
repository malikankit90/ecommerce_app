import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import 'cart_icon.dart';
import 'wishlist_icon.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final isLoggedIn = authState.value != null;

    return AppBar(
      title: const Text('ECommerce'),
      actions: [
        // 🔍 Search is always available
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            context.push('/search');
          },
        ),

        // 👤 Guest → Login
        if (!isLoggedIn)
          TextButton(
            onPressed: () => context.push('/login'),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),

        // ❤️🛒 Logged-in only
        if (isLoggedIn) ...[
          WishlistIcon(),
          CartIcon(),
        ],
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
