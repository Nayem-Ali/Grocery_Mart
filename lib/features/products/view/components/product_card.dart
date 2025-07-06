import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_mart/core/utils/toast/toast_message.dart';
import 'package:grocery_mart/data/models/cart_item.dart';
import 'package:grocery_mart/data/models/product.dart';
import 'package:grocery_mart/features/cart/controller/cart_bloc.dart';
import 'package:grocery_mart/features/cart/controller/cart_event.dart';
import 'package:grocery_mart/features/cart/controller/cart_state.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xFFE2E2E2)),
      ),
      // shadowColor: Theme.of(context).primaryColor,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: product.thumbnail,
                fit: BoxFit.cover,
                width: double.infinity,
                errorWidget:
                    (context, url, error) => Icon(Icons.image, size: 50),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              // width: 140,
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ), //#7C7C7C
            Text(
              'Rating: ${product.rating} ★',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                // fontWeight: FontWeight.bold,
                color: Color(0xFF7C7C7C),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$ ${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        final cartBloc = context.read<CartBloc>();
                        cartBloc.add(
                          AddToCartEvent(
                            cartItem: CartItem.fromProduct(product),
                          ),
                        );
                        if (cartBloc.state is CartSuccessState) {
                          ToastMessage.success(
                            message: "Product Added to Cart",
                          );
                        } else {
                          ToastMessage.failure(message: 'Something went wrong');
                        }
                      },
                      child: Icon(Icons.add, size: 30, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
