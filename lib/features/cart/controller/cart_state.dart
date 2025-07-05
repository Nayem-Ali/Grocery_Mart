import 'package:equatable/equatable.dart';
import 'package:grocery_mart/data/models/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitialState extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

class CartSuccessState extends CartState {
  final List<CartItem> cartItems;
  const CartSuccessState({required this.cartItems});
  @override
  List<Object?> get props => [];
}

class CartErrorState extends CartState {
  final String message;

  const CartErrorState({required this.message});
  @override
  List<Object?> get props => [];
}
