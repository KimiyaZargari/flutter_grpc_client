import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';

class DeleteCategory implements UseCase<int, Empty> {
  final ICategoriesRepository repository;

  DeleteCategory(this.repository);

  @override
  Future<Empty> call(id) async {
    return await repository.deleteCategory(ID(id: id));
  }
}
