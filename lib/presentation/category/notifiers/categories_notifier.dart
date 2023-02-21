import 'package:flutter_grpc_client/application/category/fetch_categories.dart';
import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/infrastructure/category/categories_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  Categories categories;

  CategoriesLoaded(this.categories);
}

class CategoriesError extends CategoriesState {
  String message;

  CategoriesError(this.message);
}

class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final ICategoriesRepository repository;

  CategoriesNotifier({required this.repository}) : super(CategoriesLoading());

  fetchCategories() async {
    FetchCategories fetchCategories = FetchCategories(repository);
    var categories = await fetchCategories(Empty());
    state = CategoriesLoaded(categories);
  }

  deleteCategory(int id) async {}
  editCategory(int id) async {}
}
