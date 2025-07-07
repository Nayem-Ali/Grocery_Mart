import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grocery_mart/core/local_db/shared_pref/shared_pref_keys.dart';
import 'package:grocery_mart/core/local_db/shared_pref/shared_pref_manager.dart';
import 'package:grocery_mart/data/models/cart_item.dart';
import 'package:grocery_mart/data/services/local/cart_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mock_data/cart_mock_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late SharedPreferenceManager sharedPreferenceManager;
  late CartServices cartServices;
  late List<CartItem> cartItems;

  setUp(() async {
    cartItems = mockCartProducts;
    SharedPreferences.setMockInitialValues({
      SharedPrefKeys.cart: [jsonEncode(cartItems.first.toJson())],
    });
    sharedPreferenceManager = SharedPreferenceManager();
    await sharedPreferenceManager.init();
    cartServices = CartServices(
      sharedPreferenceManager: sharedPreferenceManager,
    );
  });

  test("cart item should be added to the cart", () async {
    await cartServices.addProductToCart(cartItem: cartItems.last);
    final items = await sharedPreferenceManager.getValue(
      key: SharedPrefKeys.cart,
    );
    expect(jsonEncode(cartItems.last.toJson()), items.last);
  });

  test("cart item should be removed from the cart", () async {
    await cartServices.removeProduceFromCart(cartItem: cartItems.first);
    final items = await sharedPreferenceManager.getValue(
      key: SharedPrefKeys.cart,
    );
    expect(items.contains(jsonEncode(cartItems.first.toJson())), false);
  });
}
