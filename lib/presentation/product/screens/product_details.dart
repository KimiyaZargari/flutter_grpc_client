import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/presentation/image/widgets/app_image.dart';
import 'package:flutter_grpc_client/presentation/product/widgets/product_price.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              shrinkWrap: true,
              children: [
                AspectRatio(
                    aspectRatio: 1,
                    child: AppNetworkImage(
                        ImageLink(link: product.image))),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 8),
                  child: Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Price: ',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    ProductPriceWidget(
                      product,
                      fontSize: 18,
                    ),
                  ],
                ),
                if (product.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(product.description),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                    child: OutlinedButton(
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
                                            //call delete
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
                        child: const Text('Delete'))),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Edit'))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
