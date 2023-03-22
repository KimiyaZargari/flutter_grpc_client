import 'package:flutter_grpc_client/application/core/usecase.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';
import 'package:flutter_grpc_client/domain/core/i_core_repository.dart';

class LoadImage implements UseCase<ImageLink, AppImage> {
  final ICoreRepository repository;

  LoadImage(this.repository);

  @override
  Future<AppImage> call(ImageLink link) async {
    return await repository.loadImage(link);
  }
}
