import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/presentation/core/widgets/loading_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/all_products.dart';
import '../widgets/product_preview.dart';
import 'create_product.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(productsProvider);
    final notifier = ref.watch(productsProvider.notifier);
    if (state is ProductsLoading) notifier.fetchProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eshop Products'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CreateProductPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: state is ProductsLoaded
          ? GridView.count(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              children: state.products.products
                  .map((product) => ProductPreview(product))
                  .toList(),
            )
          : const LoadingIndicator(),
    );
  }
}
