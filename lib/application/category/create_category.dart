import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';

class CreateCategory implements UseCase<Category, Category> {
  final ICategoriesRepository repository;

  CreateCategory(this.repository);

  @override
  Future<Category> call(category) async {
    return await repository.createCategory(category);
  }
}
