import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_mart/core/local_db/shared_pref/shared_pref_keys.dart';
import 'package:grocery_mart/core/utils/logger/logger.dart';
import 'package:grocery_mart/data/models/cart_item.dart';
import 'package:grocery_mart/data/services/local/cart_services.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartServices cartServices;

  CartBloc({required this.cartServices}) : super(CartInitialState()) {
    on<GetCartItemsEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<IncreaseCartItemQuantityEvent>(_onIncreaseQuantity);
    on<DecreaseCartItemQuantityEvent>(_onDecreaseQuantity);
  }

  Future<void> _onLoadCart(
    GetCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    try {
      final items = await cartServices.getProductFromCart();
      debug(items);
      emit(CartSuccessState(cartItems: items));
    } catch (e) {
      emit(const CartErrorState(message: 'Failed to load cart'));
    }
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoadingState());
      final response = await cartServices.addProductToCart(
        cartItem: event.cartItem,
      );
      if (response) {
        final updatedItems = await cartServices.getProductFromCart();
        emit(CartSuccessState(cartItems: updatedItems));
      } else {
        emit(const CartErrorState(message: 'Already added to the cart'));
      }
    } catch (e) {
      emit(const CartErrorState(message: 'Failed to add item to cart'));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoadingState());
      await cartServices.removeProduceFromCart(cartItem: event.cartItem);
      final updatedItems = await cartServices.getProductFromCart();
      emit(CartSuccessState(cartItems: updatedItems));
    } catch (e) {
      emit(const CartErrorState(message: 'Failed to remove item from cart'));
    }
  }

  Future<void> _onIncreaseQuantity(
    IncreaseCartItemQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoadingState());
      List<CartItem> cartItems = await cartServices.getProductFromCart();
      int index = cartItems.indexWhere((item) => item.id == event.cartItem.id);
      if (index != -1 && event.cartItem.stock >= cartItems[index].quantity) {
        cartItems[index].quantity += 1;
        await cartServices.sharedPreferenceManager.insertValue(
          key: SharedPrefKeys.cart,
          data: cartItems.map((e) => jsonEncode(e.toJson())).toList(),
        );
      }
      emit(CartSuccessState(cartItems: cartItems));
    } catch (e) {
      emit(const CartErrorState(message: 'Failed to increase quantity'));
    }
  }

  Future<void> _onDecreaseQuantity(
    DecreaseCartItemQuantityEvent event,
    Emitter<CartState> emit,
  ) async {
    try {
      emit(CartLoadingState());
      List<CartItem> cartItems = await cartServices.getProductFromCart();
      int index = cartItems.indexWhere((item) => item.id == event.cartItem.id);
      if (index != -1 && cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
        await cartServices.sharedPreferenceManager.insertValue(
          key: SharedPrefKeys.cart,
          data: cartItems.map((e) => jsonEncode(e.toJson())).toList(),
        );
      }
      emit(CartSuccessState(cartItems: cartItems));
    } catch (e) {
      emit(const CartErrorState(message: 'Failed to decrease quantity'));
    }
  }
}
