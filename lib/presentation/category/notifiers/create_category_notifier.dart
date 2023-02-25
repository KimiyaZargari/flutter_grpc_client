import 'package:flutter/cupertino.dart';
import 'package:flutter_grpc_client/application/category/create_category.dart';
import 'package:flutter_grpc_client/application/core/upload_images.dart';
import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/core/i_core_repository.dart';

abstract class CreateCategoryState {}

class CreatingCategory extends CreateCategoryState {}

class CreateCategoryInitial extends CreateCategoryState {}

class CategoryCreated extends CreateCategoryState {}

class CreateCategoryError extends CreateCategoryState {
  String message;

  CreateCategoryError(this.message);
}

class CreateCategoryNotifier extends StateNotifier<CreateCategoryState> {
  final ICategoriesRepository categoryRepository;
  final ICoreRepository coreRepository;
  final formKey = GlobalKey<FormState>();
  late String categoryName;
  XFile? image;

  CreateCategoryNotifier(
      {required this.categoryRepository, required this.coreRepository})
      : super(CreateCategoryInitial());

  createCategory() async {
    state = CreatingCategory();
    if (image != null) {
      UploadImages uploadImages = UploadImages(coreRepository);
      await uploadImages(image!);
    }
    CreateCategory createCategory = CreateCategory(categoryRepository);
    await createCategory(Category(name: categoryName));
    state = CategoryCreated();
  }

  setImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    image = await picker.pickImage(source: ImageSource.gallery);
    state = CreateCategoryInitial();
  }
}
