import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/presentation/image/widgets/app_image.dart';

class ProductPreview extends StatelessWidget {
  final Product product;
  final Function() onDelete, onEdit;

  const ProductPreview(this.product,
      {Key? key, required this.onDelete, required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: product.mainProductImage.isNotEmpty
                      ? AppNetworkImage(
                          ImageLink(imageLink: product.mainProductImage))
                      : Container(
                          color: Colors.grey[200],
                          child:
                              const Icon(Icons.image_not_supported_outlined)),
                ),
                SizedBox(height: 10,),
                Text(
                  product.name,
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
                      color: Colors.grey,
                    )),
                Expanded(
                  child: OutlinedButton(
                      onPressed: onEdit, child: const Text('Edit')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
