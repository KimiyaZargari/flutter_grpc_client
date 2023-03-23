import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/domain/core/generated/eshop.pb.dart';
import 'package:flutter_grpc_client/presentation/image/widgets/app_image.dart';
import 'package:flutter_grpc_client/presentation/product/screens/product_details.dart';
import 'package:flutter_grpc_client/presentation/product/widgets/product_price.dart';

class ProductPreview extends StatelessWidget {
  final Product product;

  const ProductPreview(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ProductDetailsPage(product)));
      },
      behavior: HitTestBehavior.opaque,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                      aspectRatio: 1,
                      child: AppNetworkImage(ImageLink(link: product.image))),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ProductPriceWidget(product))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
