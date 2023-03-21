import 'package:flutter_grpc_client/application/core/load_image.dart';
import 'package:flutter_grpc_client/domain/core/i_core_repository.dart';
import 'package:flutter_grpc_client/infrastructure/core/core_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/core/generated/eshop.pb.dart';

final imageProvider = StateNotifierProvider.autoDispose
    .family<ImageNotifier, ImageState, ImageLink>((ref, link) =>
        ImageNotifier(link, repository: ref.watch(coreRepositoryProvider)));

abstract class ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  AppImage image;

  ImageLoaded(this.image);
}

class ImageNotifier extends StateNotifier<ImageState> {
  final ICoreRepository repository;
  final ImageLink imageLink;

  ImageNotifier(this.imageLink, {required this.repository})
      : super(ImageLoading());

  loadImage() async {
    print('loading');
    LoadImage loadImage = LoadImage(repository);
    state = ImageLoaded(await loadImage(imageLink));
  }
}
