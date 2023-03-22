import '../core/generated/eshop.pb.dart';

abstract class IProductRepository {
  Future<Products> fetchProducts(Empty empty);

  Future<Product> createProduct(Product product);

  Future<Empty> deleteProduct(ID id);
}
