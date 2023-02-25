import 'package:image_picker/image_picker.dart';

import '../core/generated/eshop.pb.dart';

abstract class ICoreRepository {
  Future<ImageLinks> uploadImages(XFile image);

}
