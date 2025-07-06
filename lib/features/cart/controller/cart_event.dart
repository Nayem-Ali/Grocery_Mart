import 'package:equatable/equatable.dart';
import 'package:grocery_mart/data/models/cart_item.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class GetCartItemsEvent extends CartEvent {}

class IncreaseCartItemQuantityEvent extends CartEvent {
  final CartItem cartItem;
  const IncreaseCartItemQuantityEvent({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class DecreaseCartItemQuantityEvent extends CartEvent {
  final CartItem cartItem;
  const DecreaseCartItemQuantityEvent({required this.cartItem});
  @override
  List<Object?> get props => [cartItem];
}

class AddToCartEvent extends CartEvent {
  final CartItem cartItem;
  const AddToCartEvent({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}

class RemoveFromCartEvent extends CartEvent {
  final CartItem cartItem;
  const RemoveFromCartEvent({required this.cartItem});

  @override
  List<Object?> get props => [cartItem];
}
