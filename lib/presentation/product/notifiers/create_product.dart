import 'package:flutter/cupertino.dart';
import 'package:flutter_grpc_client/application/core/upload_image.dart';
import 'package:flutter_grpc_client/domain/product/i_product_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/infrastructure/product/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../application/product/create_product.dart';
import '../../../domain/core/i_core_repository.dart';
import '../../../infrastructure/core/core_repository.dart';

final createProductProvider = StateNotifierProvider.autoDispose<
        CreateProductNotifier, CreateProductState>(
    (ref) => CreateProductNotifier(
        productRepository: ref.watch(productRepositoryProvider),
        coreRepository: ref.watch(coreRepositoryProvider)));

abstract class CreateProductState {}

class CreatingProduct extends CreateProductState {}

class CreateProductInitial extends CreateProductState {}

class ProductCreated extends CreateProductState {}

class CreateProductError extends CreateProductState {
  String message;

  CreateProductError(this.message);
}

class CreateProductNotifier extends StateNotifier<CreateProductState> {
  final IProductRepository productRepository;
  final ICoreRepository coreRepository;
  final formKey = GlobalKey<FormState>();
  Product product = Product();
  XFile? image;

  CreateProductNotifier(
      {required this.productRepository, required this.coreRepository})
      : super(CreateProductInitial());

  createProduct() async {
    state = CreatingProduct();
    ImageLink? imageLink;
    if (image != null) {
      UploadImage uploadImage = UploadImage(coreRepository);
      imageLink = await uploadImage(image!);
      product.image = imageLink.link;
    }
    CreateProduct createProduct = CreateProduct(productRepository);
    await createProduct(product);
    state = ProductCreated();
  }

  setImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    state = CreateProductInitial();
  }
}
