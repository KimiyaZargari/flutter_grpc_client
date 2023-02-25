import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/providers.dart';

class CreateCategoryPage extends ConsumerWidget {
  const CreateCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(createCategoryProvider);
    final notifier = ref.watch(createCategoryProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Category'),
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
              TextFormField(
                onSaved: (val) {
                  notifier.categoryName = val!;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter category name!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text('name'), border: OutlineInputBorder()),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (notifier.formKey.currentState!.validate()) {
                      notifier.formKey.currentState!.save();
                      notifier.createCategory();
                    }
                  },
                  child: const Text('done'))
            ],
          ),
        ),
      ),
    );
  }
}
