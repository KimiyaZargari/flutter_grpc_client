import 'package:image_picker/image_picker.dart';

import '../core/generated/eshop.pb.dart';

abstract class ICoreRepository {
  Future<ImageLink> uploadImage(XFile image);
  Future<AppImage> loadImage(ImageLink link);

}
