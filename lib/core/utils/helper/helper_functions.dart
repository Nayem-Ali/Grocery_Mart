import 'package:grocery_mart/data/models/cart_item.dart';

class HelperFunctions {
  static String calculateSubtotal(List<CartItem> cartItems) {
    double subTotal = cartItems.fold(
      0.0,
      (sum, item) => sum + item.quantity * item.price,
    );
    return subTotal.toStringAsFixed(2);
  }
}
