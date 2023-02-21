import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
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
  CategoriesNotifier() : super(CategoriesLoading());

  fetchCategories() async {}

}
