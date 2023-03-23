import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_grpc_client/presentation/core/widgets/loading_indicator.dart';
import '../notifiers/create_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/all_products.dart';
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
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ImageWidget(
                              image: notifier.image,
                              setImage: () => notifier.setImage(),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  onSaved: (val) {
                                    if (val != null && val.isNotEmpty) {
                                      notifier.product.price =
                                          double.parse(val);
                                    }
                                  },
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please enter price!';
                                    } else if (val == '0') {
                                      return 'Price must be nonzero!';
                                    }

                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      label: Text('price*'),
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  onSaved: (val) {
                                    if (val == null || val.isEmpty) {
                                      val = '0';
                                    }
                                    notifier.product.discount =
                                        double.parse(val);
                                  },
                                  validator: (_) {
                                    if (notifier.product.discount >=
                                            notifier.product.price &&
                                        notifier.product.price != 0) {
                                      return 'Invalid discount!';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      label: Text('discount'),
                                      border: OutlineInputBorder()),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: TextFormField(
                        onSaved: (val) {
                          if (val != null && val.isNotEmpty) {
                            notifier.product.name = val;
                          }
                        },
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter product name!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text('name*'), border: OutlineInputBorder()),
                      ),
                    ),
                    TextFormField(
                      maxLines: 5,
                      onSaved: (val) {
                        if (val != null) {
                          notifier.product.description = val.trim();
                        }
                      },
                      decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          label: Text(
                            'description',
                          ),
                          border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    notifier.formKey.currentState!.save();
                    if (notifier.formKey.currentState!.validate()) {
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
