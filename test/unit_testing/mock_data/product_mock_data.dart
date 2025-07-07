import 'package:grocery_mart/data/models/product.dart';

List<Map<String, dynamic>> dummyData = [
  {
    "id": 16,
    "title": "Apple",
    "description":
        "Fresh and crisp apples, perfect for snacking or incorporating into various recipes.",
    "category": "Fruits",
    "categoryImage": "https://freepngimg.com/thumb/categories/1028.png",
    "price": 1.99,
    "discountPercentage": 12.62,
    "rating": 4.19,
    "stock": 26,
    "thumbnail":
        "https://cdn.dummyjson.com/product-images/groceries/apple/thumbnail.webp",
  },
  {
    "id": 17,
    "title": "Beef Steak",
    "description":
        "High-quality beef steak, great for grilling or cooking to your preferred level of doneness.",
    "category": "Meat",
    "categoryImage":
        "https://static.vecteezy.com/system/resources/previews/049/672/093/non_2x/meat-steak-icon-free-png.png",
    "price": 12.99,
    "discountPercentage": 9.61,
    "rating": 4.47,
    "stock": 86,
    "thumbnail":
        "https://cdn.dummyjson.com/product-images/groceries/beef-steak/thumbnail.webp",
  },
  {
    "id": 18,
    "title": "Cat Food",
    "description":
        "Nutritious cat food formulated to meet the dietary needs of your feline friend.",
    "category": "Pet Food",
    "categoryImage":
        "https://static.vecteezy.com/system/resources/previews/009/384/398/non_2x/dog-bowl-clipart-design-illustration-free-png.png",
    "price": 8.99,
    "discountPercentage": 9.58,
    "rating": 3.13,
    "stock": 46,
    "weight": 10,
    "thumbnail":
        "https://cdn.dummyjson.com/product-images/groceries/cat-food/thumbnail.webp",
  },
];

List<Product> mockProducts = dummyData.map((e) => Product.fromJson(e)).toList();
