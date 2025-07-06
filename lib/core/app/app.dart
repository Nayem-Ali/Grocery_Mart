import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_mart/core/dependency_injection/dependency_injection.dart';
import 'package:grocery_mart/core/route/app_routes.dart';
import 'package:grocery_mart/core/theme/app_theme.dart';
import 'package:grocery_mart/features/cart/controller/cart_bloc.dart';
import 'package:grocery_mart/features/products/controller/product_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl.get<ProductBloc>()),
        BlocProvider(create: (context) => sl.get<CartBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Grocery Mart',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: appRoutes,
        builder: BotToastInit(),
      ),
    );
  }
}
