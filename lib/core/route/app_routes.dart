import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_mart/core/route/routes_name.dart';
import 'package:grocery_mart/features/shared/view/navigation_screen.dart';
import 'package:grocery_mart/features/shared/view/splash_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> sectionNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRoutes = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      name: "/splash",
      path: RoutesName.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: "/navigation",
      path: RoutesName.navigation,
      builder: (context, state) {
        return const NavigationScreen();
      },
    ),
    // StatefulShellRoute.indexedStack(
    //   // builder: (context, state, navigationShell) => null,
    //   branches: [],
    // ),
    // GoRoute(
    //   path: "/product",
    //   name: RoutesName.product,
    //   // builder: (context, state) {
    //   //   Product product = state.extra as Product;
    //   //   return ProductDetailsScreen(product: product);
    //   // },
    // ),
  ],
);
