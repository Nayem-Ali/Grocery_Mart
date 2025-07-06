import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_mart/core/route/routes_name.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';
import 'package:grocery_mart/core/utils/toast/toast_message.dart';
import 'package:grocery_mart/features/products/controller/product_bloc.dart';
import 'package:grocery_mart/features/products/controller/product_event.dart';
import 'package:grocery_mart/features/products/controller/product_state.dart';
import 'package:grocery_mart/features/products/view/components/product_card.dart';
import 'package:grocery_mart/features/shared/widgets/k_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Mart'),
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
              KTextFormField(
                textEditingController: _searchController,
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                onChange: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    // Call your search/filter logic here
                    debug('Search query: $value');
                    context.read<ProductBloc>().add(
                      SearchProductEvent(searchKey: value),
                    );
                    // Example:
                  });
                },
              ),
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
                      return const Center(child: Text("Something went wrong"));
                    }
                    return const Center(child: Text('No products available'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
