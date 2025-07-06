import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_mart/core/route/routes_name.dart';
import 'package:grocery_mart/core/utils/toast/toast_message.dart';
import 'package:grocery_mart/features/products/controller/product_bloc.dart';
import 'package:grocery_mart/features/products/controller/product_event.dart';
import 'package:grocery_mart/features/products/controller/product_state.dart';
import 'package:grocery_mart/features/products/view/components/product_card.dart';

class CategorizedProductScreen extends StatefulWidget {
  const CategorizedProductScreen({super.key, required this.category});
  final String category;
  @override
  State<CategorizedProductScreen> createState() =>
      _CategorizedProductScreenState();
}

class _CategorizedProductScreenState extends State<CategorizedProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
      GetProductByCategoryEvent(category: widget.category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        context.read<ProductBloc>().add(GetProductEvent());
        // return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
          centerTitle: true,
          actions: [
            // Sort Button
            PopupMenuButton<String>(
              onSelected: (value) {
                bool ascending = value == 'Low to High';
                context.read<ProductBloc>().add(
                  SortProductByPriceEvent(doesAscending: ascending),
                );
              },
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(
                      value: 'Low to High',
                      child: Text('Price: Low to High'),
                    ),
                    const PopupMenuItem(
                      value: 'High to Low',
                      child: Text('Price: High to Low'),
                    ),
                  ],
              icon: const Icon(Icons.sort),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                      if (state is ProductFailureState) {
                        ToastMessage.failure(message: 'Something went wrong');
                      }
                    },
                    builder: (context, state) {
                      if (state is ProductLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductSuccessState) {
                        final products = state.products;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                mainAxisExtent: 270,
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return InkWell(
                              onTap:
                                  () => context.pushNamed(
                                    RoutesName.productDetails,
                                    extra: product,
                                  ),
                              child: ProductCard(product: product),
                            );
                          },
                        );
                      } else if (state is ProductFailureState) {
                        return const Center(
                          child: Text("Something went wrong"),
                        );
                      }
                      return const Center(child: Text('No products available'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
