import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:grocery_mart/core/route/app_routes.dart';
import 'package:grocery_mart/core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Grocery Mart',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRoutes,
      builder: BotToastInit(),
    );
  }
}
