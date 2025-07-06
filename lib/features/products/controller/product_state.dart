import 'package:equatable/equatable.dart';
import 'package:grocery_mart/data/models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductSuccessState extends ProductState {
  final List<Product> products;

  const ProductSuccessState({required this.products});

  @override
  List<Object?> get props => [];
}

class ProductFailureState extends ProductState {
  @override
  List<Object?> get props => [];
}

//
// class CategorizedProductSuccessState extends ProductState {
//   final List<Product> categorizedProducts;
//
//   const CategorizedProductSuccessState({required this.categorizedProducts});
//
//   @override
//   List<Object?> get props => [];
// }
//
// class CategorizedProductFailureState extends ProductState {
//   @override
//   List<Object?> get props => [];
// }
//
// class CategorizedProductLoadingState extends ProductState {
//   @override
//   List<Object?> get props => [];
// }
