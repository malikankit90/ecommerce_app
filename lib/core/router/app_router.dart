// lib/core/router/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';

import '../../features/home/presentation/screens/home_screen.dart';

import '../../features/categories/data/models/category_model.dart';
import '../../features/categories/presentation/screens/category_landing_screen.dart';

import '../../features/products/presentation/screens/products_list_screen.dart';
import '../../features/products/presentation/screens/product_detail_screen.dart';
import '../../features/products/presentation/screens/search_screen.dart';

import '../../features/cart/presentation/screens/cart_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/checkout/presentation/screens/order_success_screen.dart';

import '../../features/orders/presentation/screens/orders_list_screen.dart';
import '../../features/orders/presentation/screens/order_detail_screen.dart';

import '../../features/address/presentation/screens/addresses_list_screen.dart';
import '../../features/address/presentation/screens/add_edit_address_screen.dart';

import '../../features/wishlist/presentation/screens/wishlist_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,

    // =====================================================
    // AUTH + GUEST REDIRECT LOGIC (FINAL)
    // =====================================================
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;

      // Auth-only screens
      final isAuthRoute =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup' ||
          state.matchedLocation == '/forgot-password';

      // Routes that guests ARE ALLOWED to access
      const guestAllowedRoutes = [
        '/',
        '/category',
        '/products',
        '/search',
      ];

      final isGuestAllowed = guestAllowedRoutes
          .any((path) => state.matchedLocation.startsWith(path));

      // 🚫 Guest trying to access protected route
      if (!isLoggedIn && !isAuthRoute && !isGuestAllowed) {
        return '/login';
      }

      // 🚫 Logged-in user trying to access auth screens
      if (isLoggedIn && isAuthRoute) {
        return '/';
      }

      return null;
    },

    // =====================================================
    // ROUTES
    // =====================================================
    routes: [
      // =============================
      // HOME (PUBLIC)
      // =============================
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // =============================
      // AUTH
      // =============================
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),

      GoRoute(
        path: '/forgot-password',
        name: 'forgotPassword',
        builder: (context, state) =>
            const ForgotPasswordScreen(),
      ),

      // =============================
      // CATEGORY LANDING (PUBLIC)
      // =============================
      GoRoute(
        path: '/category',
        name: 'categoryLanding',
        builder: (context, state) {
          final category = state.extra as CategoryModel;
          return CategoryLandingScreen(
            rootCategory: category,
          );
        },
      ),

      // =============================
      // PRODUCTS (PUBLIC)
      // =============================
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) {
          final extra =
              state.extra as Map<String, dynamic>?;

          return ProductsListScreen(
            categoryId: extra?['categoryId'],
            title: extra?['title'],
          );
        },
      ),

      GoRoute(
        path: '/products/:id',
        name: 'productDetail',
        builder: (context, state) {
          final productId =
              state.pathParameters['id']!;
          return ProductDetailScreen(
            productId: productId,
          );
        },
      ),

      // =============================
      // SEARCH (PUBLIC)
      // =============================
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) =>
            const SearchScreen(),
      ),

      // =============================
      // CART (AUTH REQUIRED)
      // =============================
      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) =>
            const CartScreen(),
      ),

      // =============================
      // CHECKOUT (AUTH REQUIRED)
      // =============================
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) =>
            const CheckoutScreen(),
      ),

      // =============================
      // ORDERS (AUTH REQUIRED)
      // =============================
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) =>
            const OrdersListScreen(),
      ),

      GoRoute(
        path: '/orders/:id',
        name: 'orderDetail',
        builder: (context, state) {
          final orderId =
              state.pathParameters['id']!;
          return OrderDetailScreen(
            orderId: orderId,
          );
        },
      ),

      GoRoute(
        path: '/orders/:id/success',
        name: 'orderSuccess',
        builder: (context, state) {
          final orderId =
              state.pathParameters['id']!;
          return OrderSuccessScreen(
            orderId: orderId,
          );
        },
      ),

      // =============================
      // ADDRESSES (AUTH REQUIRED)
      // =============================
      GoRoute(
        path: '/addresses',
        name: 'addresses',
        builder: (context, state) =>
            const AddressesListScreen(),
      ),

      GoRoute(
        path: '/addresses/add',
        name: 'addAddress',
        builder: (context, state) =>
            const AddEditAddressScreen(),
      ),

      GoRoute(
        path: '/addresses/edit/:id',
        name: 'editAddress',
        builder: (context, state) {
          final address = state.extra;
          return AddEditAddressScreen(
            address: address as dynamic,
          );
        },
      ),

      // =============================
      // WISHLIST (AUTH REQUIRED)
      // =============================
      GoRoute(
        path: '/wishlist',
        name: 'wishlist',
        builder: (context, state) =>
            const WishlistScreen(),
      ),
    ],

    // =====================================================
    // ERROR PAGE
    // =====================================================
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text('Error: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
