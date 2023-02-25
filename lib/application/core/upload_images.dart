import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';
import 'package:flutter_grpc_client/domain/core/i_core_repository.dart';
import 'package:image_picker/image_picker.dart';

class UploadImages implements UseCase<XFile, ImageLinks> {
  final ICoreRepository repository;

  UploadImages(this.repository);

  @override
  Future<ImageLinks> call(XFile images) async {
    return await repository.uploadImages(images);
  }
}
