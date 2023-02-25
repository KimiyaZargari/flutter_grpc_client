import 'package:flutter/cupertino.dart';
import 'package:flutter_grpc_client/application/category/create_category.dart';
import 'package:flutter_grpc_client/application/category/fetch_categories.dart';
import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/infrastructure/category/categories_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class CreateCategoryState {}

class CreatingCategory extends CreateCategoryState {}

class CreateCategoryInitial extends CreateCategoryState {}

class CategoryCreated extends CreateCategoryState {}

class CreateCategoryError extends CreateCategoryState {
  String message;

  CreateCategoryError(this.message);
}

class CreateCategoryNotifier extends StateNotifier<CreateCategoryState> {
  final ICategoriesRepository repository;
  final formKey = GlobalKey<FormState>();
  late String categoryName;

  CreateCategoryNotifier({required this.repository})
      : super(CreateCategoryInitial());

  createCategory() async {
    state = CreatingCategory();
    CreateCategory createCategory = CreateCategory(repository);
    await createCategory(Category(name: categoryName));
    state = CategoryCreated();
  }
}
