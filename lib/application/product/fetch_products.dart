import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/product/i_product_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';

class FetchProducts implements UseCase<Empty, Products> {
  final IProductRepository repository;

  FetchProducts(this.repository);

  @override
  Future<Products> call(empty) async {
    return await repository.fetchProducts(empty);
  }
}
