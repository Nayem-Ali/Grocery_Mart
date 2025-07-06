import 'dart:convert';

import 'package:grocery_mart/core/local_db/shared_pref/shared_pref_keys.dart';
import 'package:grocery_mart/core/local_db/shared_pref/shared_pref_manager.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';
import 'package:grocery_mart/data/models/cart_item.dart';

class CartServices {
  final SharedPreferenceManager sharedPreferenceManager;

  CartServices({required this.sharedPreferenceManager});

  Future<bool> addProductToCart({required CartItem cartItem}) async {
    try {
      List<String> cartItems =
          sharedPreferenceManager.getValue(key: SharedPrefKeys.cart) ?? [];
      debug(cartItems);
      String newCartItem = jsonEncode(cartItem.toJson());
      if (cartItems.contains(newCartItem)) {
        return false;
      } else {
        cartItems.removeWhere(
          (element) => element.substring(0, 20) == newCartItem.substring(0, 20),
        );
        cartItems.add(jsonEncode(cartItem.toJson()));

        return await sharedPreferenceManager.insertValue(
          key: SharedPrefKeys.cart,
          data: cartItems,
        );
      }
    } catch (e) {
      debug(e);
    }
    return false;
  }

  Future<List<CartItem>> getProductFromCart() async {
    try {
      List<String> cartItems = List<String>.from(
        sharedPreferenceManager.getValue(key: SharedPrefKeys.cart) ?? [],
      );
      debug(cartItems);
      return cartItems
          .map((cartItem) => CartItem.fromJson(jsonDecode(cartItem)))
          .toList();
    } catch (e) {
      debug(e);
    }
    return [];
  }

  Future<bool> removeProduceFromCart({required CartItem cartItem}) async {
    try {
      List<String> cartItems =
          sharedPreferenceManager.getValue(key: SharedPrefKeys.cart) ?? [];
      if (cartItems.contains(jsonEncode(cartItem.toJson()))) {
        cartItems.remove(jsonEncode(cartItem.toJson()));
        return await sharedPreferenceManager.insertValue(
          key: SharedPrefKeys.cart,
          data: cartItems,
        );
      }
    } catch (e) {
      debug(e);
    }
    return false;
  }
}
