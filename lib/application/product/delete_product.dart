import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';

import '../../domain/product/i_product_repository.dart';

class DeleteProduct implements UseCase<int, Empty> {
  final IProductRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<Empty> call(id) async {
    return await repository.deleteProduct(Id(id: id));
  }
}
