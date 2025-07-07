import 'package:grocery_mart/data/models/cart_item.dart';

List<Map<String, dynamic>> cartDummyData = [
  {
    "id": 16,
    "title": "Apple",
    "category": "Fruits",
    "price": 1.99,
    "discountPercentage": 12.62,
    "rating": 4.19,
    "stock": 26,
    "thumbnail":
        "https://cdn.dummyjson.com/product-images/groceries/apple/thumbnail.webp",
    "quantity": 1,
  },
  {
    "id": 17,
    "title": "Beef Steak",
    "category": "Meat",
    "price": 12.99,
    "discountPercentage": 9.61,
    "rating": 4.47,
    "stock": 86,
    "thumbnail":
        "https://cdn.dummyjson.com/product-images/groceries/beef-steak/thumbnail.webp",
    "quantity": 1,
  },
  {
    "id": 18,
    "title": "Cat Food",
    "category": "Pet Food",
    "price": 8.99,
    "discountPercentage": 9.58,
    "rating": 3.13,
    "stock": 46,
    "weight": 10,
    "thumbnail":
        "https://cdn.dummyjson.com/product-images/groceries/cat-food/thumbnail.webp",
    "quantity": 1,
  },
];

List<CartItem> mockCartProducts =
    cartDummyData.map((e) => CartItem.fromJson(e)).toList();
