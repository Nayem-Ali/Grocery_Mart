import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_mart/core/utils/helper/helper_functions.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';
import 'package:grocery_mart/core/utils/toast/toast_message.dart';
import 'package:grocery_mart/data/models/cart_item.dart';
import 'package:grocery_mart/features/cart/controller/cart_bloc.dart';
import 'package:grocery_mart/features/cart/controller/cart_event.dart';
import 'package:grocery_mart/features/cart/controller/cart_state.dart';
import 'package:grocery_mart/features/shared/widgets/k_elevated_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double subTotal = 0.0;
  @override
  void initState() {
    super.initState();
    debug('Called');
    context.read<CartBloc>().add(GetCartItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: BlocConsumer<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartSuccessState) {
            if (state.cartItems.isEmpty) {
              return Center(child: Text("No Product Found in Cart"));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        CartItem cartItem = state.cartItems[index];
                        subTotal += cartItem.quantity * cartItem.price;
                        return Container(
                          height: 110,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: Colors.grey)),
                          ),
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: cartItem.thumbnail,
                                fit: BoxFit.cover,
                                errorWidget:
                                    (context, url, error) =>
                                        Icon(Icons.image, size: 35),
                              ),
                              SizedBox(width: 7),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cartItem.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      'Stock: ${cartItem.stock}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFB3B3B3),
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            context.read<CartBloc>().add(
                                              DecreaseCartItemQuantityEvent(
                                                cartItem: cartItem,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            color: const Color(0xFFB3B3B3),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        cartItem.quantity.toString(),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,

                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            context.read<CartBloc>().add(
                                              IncreaseCartItemQuantityEvent(
                                                cartItem: cartItem,
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.add,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<CartBloc>().add(
                                        RemoveFromCartEvent(cartItem: cartItem),
                                      );
                                    },
                                    child: Icon(Icons.close),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: SizedBox(
                                      // width: 150,
                                      child: Text(
                                        '\$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Stack(
                    children: [
                      KElevatedButton(
                        onPressed: () {},
                        buttonTitle: "Go to Checkout",
                      ),
                      Positioned(
                        right: 35,
                        top: 28,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.black12,
                          ),
                          child: Center(
                            child: Text(
                              '\$${HelperFunctions.calculateSubtotal(state.cartItems)}',
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is CartLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartErrorState) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text("No Product Found in Cart"));
          }
        },
        listener: (context, state) {
          if (state is CartErrorState) {
            ToastMessage.failure(message: state.message);
          }
        },
      ),
    );
  }
}
