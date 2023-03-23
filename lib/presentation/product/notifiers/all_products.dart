import 'package:flutter_grpc_client/application/product/fetch_products.dart';
import 'package:flutter_grpc_client/domain/product/i_product_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/product/product_repository.dart';

final productsProvider =
    StateNotifierProvider.autoDispose<ProductsNotifier, ProductsState>((ref) =>
        ProductsNotifier(repository: ref.watch(productRepositoryProvider)));

abstract class ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  Products products;

  ProductsLoaded(this.products);
}

class ProductsError extends ProductsState {
  String message;

  ProductsError(this.message);
}

class ProductsNotifier extends StateNotifier<ProductsState> {
  final IProductRepository repository;

  ProductsNotifier({required this.repository}) : super(ProductsLoading());

  fetchProducts() async {
    FetchProducts fetchProducts = FetchProducts(repository);
    var products = await fetchProducts(Empty());
    state = ProductsLoaded(products);
  }
}
