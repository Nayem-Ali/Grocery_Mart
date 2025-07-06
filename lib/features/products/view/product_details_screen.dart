import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_mart/core/utils/toast/toast_message.dart';
import 'package:grocery_mart/data/models/cart_item.dart';
import 'package:grocery_mart/data/models/product.dart';
import 'package:grocery_mart/features/cart/controller/cart_bloc.dart';
import 'package:grocery_mart/features/cart/controller/cart_event.dart';
import 'package:grocery_mart/features/cart/controller/cart_state.dart';
import 'package:grocery_mart/features/shared/widgets/k_elevated_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ValueNotifier<int> _quantity = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F3F2),
        title: const Text("Product Detail"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            // margin: const EdgeInsets.all(12),
            height: 230,
            decoration: BoxDecoration(
              color: Color(0xFFF2F3F2),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: NetworkImage(product.thumbnail),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 10),
          // Product Info Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 4,
              ),
              child: ListView(
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Category: ${product.category}',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C7C7C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // const Text("1kg, Price"),

                  // Quantity and Price Row
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Quantity Controller
                        ValueListenableBuilder(
                          valueListenable: _quantity,
                          builder: (context, value, child) {
                            return Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (_quantity.value > 1) {
                                      _quantity.value--;
                                    }
                                  },
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Text(
                                    _quantity.value.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    if (product.stock >= _quantity.value) {
                                      _quantity.value++;
                                    } else {
                                      ToastMessage.failure(
                                        message: "Stock limit exceeded",
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),

                        // Price
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: Colors.grey),

                  // Product Detail (Expandable)
                  ExpansionTile(
                    enabled: true,
                    collapsedShape: RoundedRectangleBorder(
                      side: BorderSide.none,
                    ),
                    shape: RoundedRectangleBorder(side: BorderSide.none),
                    tilePadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ),
                    title: Text(
                      "Product Detail",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    initiallyExpanded: true,
                    children: [
                      Text(
                        product.description,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),

                  const Divider(color: Colors.grey),

                  // Review
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Review",
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < product.rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.orange,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Add to Basket Button
          KElevatedButton(
            onPressed: () {
              final cartBloc = context.read<CartBloc>();
              cartBloc.add(
                AddToCartEvent(
                  cartItem: CartItem.fromProduct(
                    product,
                    quantity: _quantity.value,
                  ),
                ),
              );
              if (cartBloc.state is CartSuccessState) {
                ToastMessage.success(message: "Product Added to Cart");
              } else {
                ToastMessage.failure(message: 'Something went wrong');
              }
            },
            buttonTitle: "Add to Cart",
          ),
        ],
      ),
    );
  }
}
