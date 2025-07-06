import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_mart/core/route/routes_name.dart';
import 'package:grocery_mart/core/utils/toast/toast_message.dart';
import 'package:grocery_mart/features/products/controller/product_bloc.dart';
import 'package:grocery_mart/features/products/controller/product_event.dart';
import 'package:grocery_mart/features/products/controller/product_state.dart';

class ExploreProductsScreen extends StatefulWidget {
  const ExploreProductsScreen({super.key});

  @override
  State<ExploreProductsScreen> createState() => _ExploreProductsScreenState();
}

class _ExploreProductsScreenState extends State<ExploreProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore Products'), centerTitle: true),
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
                      final categories =
                          state.products
                              .map((e) => e.category)
                              .toSet()
                              .toList();
                      final categoryImages =
                          state.products
                              .map((e) => e.categoryImage)
                              .toSet()
                              .toList();
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              mainAxisExtent: 250,
                            ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context.pushNamed(
                                RoutesName.categorizedProduct,
                                extra: categories[index],
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withOpacity(0.1),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    height: 180,
                                    imageUrl: categoryImages[index],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    categories[index],
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
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
