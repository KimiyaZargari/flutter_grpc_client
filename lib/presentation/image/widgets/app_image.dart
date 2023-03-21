import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/loading_indicator.dart';
import '../notifers/image_notifier.dart';

class AppNetworkImage extends ConsumerWidget {
  final ImageLink link;

  const AppNetworkImage(this.link, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(imageProvider(link));
    final notifier = ref.watch(imageProvider(link).notifier);
    if (state is ImageLoading) notifier.loadImage();
    return state is ImageLoaded
        ? Image.memory(
            Uint8List.fromList(state.image.image),
            height: 300,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          )
        : const LoadingIndicator();
  }
}
