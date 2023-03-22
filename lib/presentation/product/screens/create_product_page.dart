import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/presentation/core/widgets/loading_indicator.dart';
import 'package:flutter_grpc_client/presentation/product/notifiers/create_product_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/products_notifier.dart';
import '../widgets/image_widget.dart';

class CreateProductPage extends ConsumerWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(createProductProvider);
    final notifier = ref.watch(createProductProvider.notifier);
    ref.listen(createProductProvider, (previous, next) {
      if (next is ProductCreated) {
        ref.invalidate(productsProvider);
        Navigator.of(context).pop();
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: notifier.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  TextFormField(
                    onSaved: (val) {
                      notifier.productName = val!;
                    },
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter product name!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        label: Text('name'), border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ImageWidget(
                    image: notifier.image,
                    setImage: () => notifier.setImage(),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    if (notifier.formKey.currentState!.validate()) {
                      notifier.formKey.currentState!.save();
                      notifier.createProduct();
                    }
                  },
                  child: state is CreatingProduct
                      ? const LoadingIndicator()
                      : const Text('create'))
            ],
          ),
        ),
      ),
    );
  }
}
