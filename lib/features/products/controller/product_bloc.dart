import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';
import 'package:grocery_mart/data/models/product.dart';
import 'package:grocery_mart/data/services/local/product_services.dart';
import 'package:grocery_mart/features/products/controller/product_event.dart';
import 'package:grocery_mart/features/products/controller/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductServices productServices;

  /// Cache of all products loaded from service
  List<Product> _allProducts = [];

  ProductBloc({required this.productServices}) : super(ProductInitialState()) {
    on<GetProductEvent>(_onGetProducts);
    on<GetProductByCategoryEvent>(_onGetProductByCategory);
    on<SortProductByPriceEvent>(_onSortProductByPrice);
    on<SearchProductEvent>(_onSearchProduct);
  }

  /// Load all products from local service and cache them
  void _onGetProducts(GetProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoadingState());
    _allProducts = await productServices.loadProducts();

    if (_allProducts.isNotEmpty) {
      emit(ProductSuccessState(products: _allProducts));
    } else {
      emit(ProductFailureState());
    }
  }

  /// Filter products by category
  void _onGetProductByCategory(
    GetProductByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());

    List<Product> filtered =
        _allProducts
            .where((product) => event.category == product.category)
            .toList();

    if (filtered.isNotEmpty) {
      emit(ProductSuccessState(products: filtered));
    } else {
      emit(ProductFailureState());
    }
  }

  /// Sort current product list by price
  void _onSortProductByPrice(
    SortProductByPriceEvent event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;

    if (currentState is ProductSuccessState) {
      emit(ProductLoadingState());

      List<Product> sorted = List.from(currentState.products);
      if (event.doesAscending) {
        sorted.sort((a, b) => a.price.compareTo(b.price));
      } else {
        sorted.sort((a, b) => b.price.compareTo(a.price));
      }

      debug(
        'Product Sorted by price: ${event.doesAscending ? "Low to High" : "High to Low"}',
      );
      emit(ProductSuccessState(products: sorted));
    }
  }

  /// Search products by title
  void _onSearchProduct(
    SearchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());

    List<Product> results =
        _allProducts
            .where(
              (product) => product.title.toLowerCase().contains(
                event.searchKey.toLowerCase(),
              ),
            )
            .toList();

    debug('Searched for "${event.searchKey}" — ${results.length} found');

    if (results.isNotEmpty) {
      emit(ProductSuccessState(products: results));
    } else {
      // Fallback to all if not found
      emit(ProductSuccessState(products: _allProducts));
    }
  }
}
