import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';
import 'package:grocery_mart/data/models/product.dart';

class ProductServices {
  Future<List<Product>> loadProducts() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/products.json',
      );
      final data = jsonDecode(response);
      debug(data);
      return (data['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList();
    } catch (e) {
      debug(e);
      return [];
    }
  }
}
