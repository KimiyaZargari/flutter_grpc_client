import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/presentation/image/widgets/app_image.dart';

class CategoryPreview extends StatelessWidget {
  final Category category;
  final Function() onDelete, onEdit;

  const CategoryPreview(this.category,
      {Key? key, required this.onDelete, required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (category.imageLink.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: AppNetworkImage(
                      ImageLink(imageLink: category.imageLink),
                      height: 60,
                      width: 60,
                    ),
                  ),
                Text(
                  category.name,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text(
                              'Are you sure you want to delete this product?'),
                          content: Row(
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        onDelete.call();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('yes!'))),
                              const SizedBox(width: 6),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  child: const Text(
                                    'no',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.orangeAccent,
                    )),
                IconButton(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.teal,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
