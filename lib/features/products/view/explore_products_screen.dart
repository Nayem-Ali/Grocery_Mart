import 'package:flutter/material.dart';
import 'package:grocery_mart/features/shared/widgets/k_text_form_field.dart';

class ExploreProductsScreen extends StatelessWidget {
  ExploreProductsScreen({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              KTextFormField(
                textEditingController: searchController,
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              Text("Explore Products"),
            ],
          ),
        ),
      ),
    );
  }
}
