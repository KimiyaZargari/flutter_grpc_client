import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pbgrpc.dart';
import 'package:flutter_grpc_client/domain/core/i_core_repository.dart';
import 'package:flutter_grpc_client/infrastructure/core/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final coreRepositoryProvider =
    Provider((ref) => CoreRepository(ref.watch(clientProvider)));

class CoreRepository extends ICoreRepository {
  ClientService client;

  CoreRepository(this.client);

  @override
  Future<ImageLink> uploadImage(XFile image) async {
    return await client.stub.uploadImage(() async* {
      bool nameSent = false;
      final imageBytes = await image.readAsBytes();

      int index = 0;
      while (index < imageBytes.length) {
        int lastIndex = index + 128;
        if (lastIndex > imageBytes.length) lastIndex = imageBytes.length;
        final data = AppImage(
          image: imageBytes.sublist(index, lastIndex),
        );
        nameSent = true;
        yield data;
        index = lastIndex;
      }
      yield AppImage(image: [], name: !nameSent ? image.name : null);
    }.call());
  }

  @override
  Future<AppImage> loadImage(ImageLink link) async {
    final List<int> image = [];
    String? name;
    await for (var element in client.stub.loadImage(link)) {
      if (element.name.isNotEmpty) {
        name = element.name;
      }
      image.addAll(element.image);
    }
    return AppImage(image: image, name: name);
  }
}
