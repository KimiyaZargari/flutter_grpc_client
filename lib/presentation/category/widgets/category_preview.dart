import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';

class CategoryPreview extends StatelessWidget {
  final Category category;

  const CategoryPreview(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(
            category.name,
          ),
        ],
      ),
    );
  }
}
