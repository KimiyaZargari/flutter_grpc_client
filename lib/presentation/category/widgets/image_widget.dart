import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatelessWidget {
  final XFile? image;
  final Function() setImage;

  const ImageWidget({required this.image, required this.setImage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: setImage,
      child: Container(
        height: MediaQuery.of(context).size.width / 2,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            image: image == null
                ? null
                : DecorationImage(
                    image: FileImage(
                      File(
                        image!.path,
                      ),
                    ),
                    fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: image != null ? null : const Icon(Icons.image),
      ),
    );
  }
}
