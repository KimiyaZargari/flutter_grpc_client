import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/widgets/loading_indicator.dart';
import '../notifers/image_notifier.dart';

class AppNetworkImage extends ConsumerWidget {
  final ImageLink link;
  final double? height, width;

  const AppNetworkImage(this.link, {this.height, this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(imageProvider(link));
    final notifier = ref.watch(imageProvider(link).notifier);
    if (state is ImageLoading) notifier.loadImage();
    return link.link.isEmpty
        ? Container(
            color: Colors.grey[200],
            child: const Icon(Icons.image_not_supported_outlined))
        : state is ImageLoaded
            ? Image.memory(
                Uint8List.fromList(state.image.image),
                fit: BoxFit.cover,
                height: width,
                width: height,
              )
            : const LoadingIndicator();
  }
}
