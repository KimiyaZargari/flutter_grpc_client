import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';
import 'package:flutter_grpc_client/infrastructure/core/client.dart';

class CategoriesRepository extends ICategoriesRepository {
  ClientService client;

  CategoriesRepository(this.client);

  @override
  Future<Categories> fetchCategories(Empty empty) async {
    //   final stub = EshopServiceClient(client.channel);
    return await client.stub.getAllCategories(empty);
  }

  @override
  Future<Empty> deleteCategory(ID id) async {
    return await client.stub.deleteCategory(id);
  }

  @override
  Future<Category> createCategory(Category category) async {
    return await client.stub.createCategory(category);
  }
}
