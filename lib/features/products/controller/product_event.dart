import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class GetProductByCategoryEvent extends ProductEvent {
  final String category;

  const GetProductByCategoryEvent({required this.category});
  @override
  List<Object?> get props => [category];
}

class SortProductByPriceEvent extends ProductEvent {
  final bool doesAscending;

  const SortProductByPriceEvent({required this.doesAscending});
  @override
  List<Object?> get props => [doesAscending];
}

class SearchProductEvent extends ProductEvent {
  final String searchKey;

  const SearchProductEvent({required this.searchKey});
  @override
  List<Object?> get props => [searchKey];
}
