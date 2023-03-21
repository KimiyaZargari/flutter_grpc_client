import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/category/i_categories_repository.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';
import 'package:flutter_grpc_client/domain/core/i_core_repository.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage implements UseCase<XFile, ImageLink> {
  final ICoreRepository repository;

  UploadImage(this.repository);

  @override
  Future<ImageLink> call(XFile image) async {
    return await repository.uploadImage(image);
  }
}
