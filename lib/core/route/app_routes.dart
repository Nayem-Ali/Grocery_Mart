import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_mart/core/route/routes_name.dart';
import 'package:grocery_mart/data/models/product.dart';
import 'package:grocery_mart/features/cart/view/cart_screen.dart';
import 'package:grocery_mart/features/home/view/home_screen.dart';
import 'package:grocery_mart/features/products/view/categorized_products_screen.dart';
import 'package:grocery_mart/features/products/view/explore_products_screen.dart';
import 'package:grocery_mart/features/products/view/product_details_screen.dart';
import 'package:grocery_mart/features/shared/view/navigation_screen.dart';
import 'package:grocery_mart/features/shared/view/splash_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> sectionNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRoutes = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: RoutesName.splash,
  routes: [
    GoRoute(
      name: RoutesName.splash,
      path: RoutesName.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    // GoRoute(
    //   name: "/home",
    //   path: RoutesName.home,
    //   builder: (context, state) {
    //     return const HomeScreen();
    //   },
    // ),
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              NavigationScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          initialLocation: RoutesName.home,
          routes: [
            GoRoute(
              name: RoutesName.home,
              path: RoutesName.home,
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RoutesName.exploreProduct,
              path: RoutesName.exploreProduct,
              builder: (context, state) => ExploreProductsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: RoutesName.cart,
              path: RoutesName.cart,
              builder: (context, state) => CartScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: RoutesName.productDetails,
      name: RoutesName.productDetails,
      builder: (context, state) {
        Product product = state.extra as Product;
        return ProductDetailsScreen(product: product);
      },
    ),
    GoRoute(
      path: RoutesName.categorizedProduct,
      name: RoutesName.categorizedProduct,
      builder: (context, state) {
        String category = state.extra as String;
        return CategorizedProductScreen(category: category);
      },
    ),
  ],
);
