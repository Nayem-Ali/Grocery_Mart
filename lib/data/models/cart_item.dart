import 'package:grocery_mart/data/models/product.dart';

class CartItem {
  int id;
  String title;
  String category;
  double price;
  double discountPercentage;
  int stock;
  String thumbnail;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.stock,
    required this.thumbnail,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      stock: json['stock'],
      thumbnail: json['thumbnail'],
      quantity: json['quantity'],
    );
  }

  factory CartItem.fromProduct(Product product, {int quantity = 1}) {
    return CartItem(
      id: product.id,
      title: product.title,
      category: product.category,
      price: product.price,
      discountPercentage: product.discountPercentage,
      stock: product.stock,
      thumbnail: product.thumbnail,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'stock': stock,
      'thumbnail': thumbnail,
      'quantity': quantity,
    };
  }
}
