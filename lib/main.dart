import 'package:flutter/material.dart';
import 'package:grocery_mart/core/app/app.dart';
import 'package:grocery_mart/core/dependency_injection/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();
  runApp(const App());
}
