import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';

import '../../domain/product/i_product_repository.dart';

class CreateProduct implements UseCase<Product, Product> {
  final IProductRepository repository;

  CreateProduct(this.repository);

  @override
  Future<Product> call(product) async {
    return await repository.createProduct(product);
  }
}
