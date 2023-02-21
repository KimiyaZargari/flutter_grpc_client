import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';

class FetchCategories implements UseCase<Empty, Categories> {
  final ICategoriesRepository repository;

  FetchCategories(this.repository);

  @override
  Future<Categories> call(empty) async {
    return await repository.fetchCategories(empty);
  }
}
