import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';
import 'package:flutter_grpc_client/infrastructure/core/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/product/i_product_repository.dart';

final productRepositoryProvider =
    Provider((ref) => ProductRepository(ref.watch(clientProvider)));

class ProductRepository extends IProductRepository {
  ClientService client;

  ProductRepository(this.client);

  @override
  Future<Products> fetchProducts(Empty empty) async {
    return await client.stub.getAllProducts(empty);
  }

  @override
  Future<Empty> deleteProduct(ID id) async {
    return await client.stub.deleteProduct(id);
  }

  @override
  Future<Product> createProduct(Product product) async {
    return await client.stub.createProduct(product);
  }
}
