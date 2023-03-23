import 'package:flutter/material.dart';

import '../../../domain/core/generated/eshop.pb.dart';

class ProductPriceWidget extends StatelessWidget {
  final Product product;
  final double? fontSize;

  const ProductPriceWidget(this.product, {this.fontSize, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${product.price}',
          style: product.discount != 0
              ? Theme.of(context).textTheme.bodySmall!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    fontSize: fontSize != null ? fontSize! - 4 : null,
                  )
              : Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.pink, fontSize: fontSize),
        ),
        if (product.discount != 0)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Text(
              ' \$${product.price - product.discount}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.pink, fontSize: fontSize),
            ),
          ),
      ],
    );
  }
}
