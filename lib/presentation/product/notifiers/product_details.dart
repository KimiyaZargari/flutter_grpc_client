import 'package:flutter/cupertino.dart';
import 'package:flutter_grpc_client/application/core/upload_image.dart';
import 'package:flutter_grpc_client/application/product/delete_product.dart';
import 'package:flutter_grpc_client/domain/product/i_product_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/infrastructure/product/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../application/product/create_product.dart';
import '../../../domain/core/i_core_repository.dart';
import '../../../infrastructure/core/core_repository.dart';

final productDetailsProvider = StateNotifierProvider.autoDispose
    .family<ProductDetailsNotifier, ProductDetailsState, Product>(
        (ref, product) => ProductDetailsNotifier(product,
            repository: ref.watch(productRepositoryProvider)));

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class DeletingProduct extends ProductDetailsState {}

class ProductDeleted extends ProductDetailsState {}

class ProductDetailsNotifier extends StateNotifier<ProductDetailsState> {
  final IProductRepository repository;
  Product product;
  XFile? image;

  ProductDetailsNotifier(this.product, {required this.repository})
      : super(ProductDetailsInitial());

  deleteProduct() async {
    state = DeletingProduct();
    DeleteProduct deleteProduct = DeleteProduct(repository);
    await deleteProduct(product.id);
    state = ProductDeleted();
  }
}
