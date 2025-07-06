import 'package:grocery_mart/core/utils/logger/logger.dart';

class Product {
  int id;
  String title;
  String description;
  String category;
  String categoryImage;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.categoryImage,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    debug(json);
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      categoryImage: json['categoryImage'],
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      thumbnail: json['thumbnail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'categoryImage': categoryImage,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'thumbnail': thumbnail,
    };
  }
}
