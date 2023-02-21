import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/presentation/category/notifiers/categories_notifier.dart';
import 'package:flutter_grpc_client/presentation/category/notifiers/create_category_page.dart';
import 'package:flutter_grpc_client/presentation/category/notifiers/providers.dart';
import 'package:flutter_grpc_client/presentation/category/widgets/category_preview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(categoriesProvider);
    final notifier = ref.watch(categoriesProvider.notifier);
    if (state is CategoriesLoading) notifier.fetchCategories();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const CreateCategoryPage()));
      }),
      body: state is CategoriesLoaded
          ? ListView(
              children: state.categories.categories
                  .map((category) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
                        child: CategoryPreview(category),
                      ))
                  .toList(),
            )
          : const CircularProgressIndicator(),
    );
  }
}
