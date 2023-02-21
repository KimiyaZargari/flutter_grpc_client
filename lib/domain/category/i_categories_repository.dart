import '../core/generated/eshop.pb.dart';

abstract class ICategoriesRepository{
  Future<Categories> fetchCategories(Empty empty);
  Future<Empty> deleteCategory(ID id);
}