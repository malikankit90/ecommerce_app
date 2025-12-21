import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/cart/presentation/providers/cart_providers.dart';
import '../../features/wishlist/presentation/providers/wishlist_providers.dart';
import 'icon_badge.dart';

class AppBottomNavBar extends ConsumerWidget {
  const AppBottomNavBar({super.key});

  int _locationToIndex(String location) {
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/wishlist')) return 2;
    if (location.startsWith('/cart')) return 3;
    if (location.startsWith('/orders')) return 4;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/wishlist');
        break;
      case 3:
        context.go('/cart');
        break;
      case 4:
        context.go('/orders');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();

    // ✅ USE EXISTING COUNT PROVIDERS
    final cartCount = ref.watch(cartItemCountProvider);
    final wishlistCount = ref.watch(wishlistItemCountProvider);

    return BottomNavigationBar(
      currentIndex: _locationToIndex(location),
      onTap: (index) => _onTap(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: IconBadge(
            icon: const Icon(Icons.favorite_border),
            count: wishlistCount,
          ),
          activeIcon: IconBadge(
            icon: const Icon(Icons.favorite),
            count: wishlistCount,
          ),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: IconBadge(
            icon: const Icon(Icons.shopping_cart_outlined),
            count: cartCount,
          ),
          activeIcon: IconBadge(
            icon: const Icon(Icons.shopping_cart),
            count: cartCount,
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
