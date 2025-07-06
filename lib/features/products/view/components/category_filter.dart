import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';
import 'package:grocery_mart/features/products/controller/product_bloc.dart';
import 'package:grocery_mart/features/products/controller/product_event.dart';
import 'package:grocery_mart/features/products/controller/product_state.dart';

class CategoryFilter extends StatelessWidget {
  CategoryFilter({super.key, required this.categories});
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CATEGORIES",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pop();
                  context.read<ProductBloc>().add(GetProductEvent());
                },
                child: const Text("Clear Filter"),
              ),
            ],
          ),
          Wrap(
            children: [
              ...categories.map(
                (category) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      final state = context.read<ProductBloc>().state;
                      if (state is ProductSuccessState) {
                        debug("Filtering by category: $category");
                        context.read<ProductBloc>().add(
                          GetProductByCategoryEvent(category: category),
                        );
                        context.pop();
                      }
                    },
                    child: Chip(label: Text(category)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
