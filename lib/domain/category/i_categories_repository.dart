import '../core/generated/eshop.pb.dart';

abstract class ICategoriesRepository {
  Future<Categories> fetchCategories(Empty empty);

  Future<Category> createCategory(Category category);

  Future<Empty> deleteCategory(ID id);
}
