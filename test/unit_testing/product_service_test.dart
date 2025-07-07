import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_mart/data/models/product.dart';
import 'package:grocery_mart/data/services/local/product_services.dart';

import 'mock_data/product_mock_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late ProductServices productServices;
  late List<Product> products;

  setUp(() {
    productServices = ProductServices();
    products = mockProducts;
  });
  test("load products should return 20 hardcoded products", () async {
    List<Product> response = await productServices.loadProducts();
    expect(response.length, 20);
  });

  test(
    "product data fetched from json file should match with mocked data",
    () async {
      List<Product> response = await productServices.loadProducts();
      expect(response.first.toJson(), products.first.toJson());
    },
  );
}
