import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/presentation/category/notifiers/categories_notifier.dart';
import 'package:flutter_grpc_client/presentation/category/screens/create_category_page.dart';
import 'package:flutter_grpc_client/presentation/category/notifiers/providers.dart';
import 'package:flutter_grpc_client/presentation/category/widgets/category_preview.dart';
import 'package:flutter_grpc_client/presentation/core/widgets/loading_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(categoriesProvider);
    final notifier = ref.watch(categoriesProvider.notifier);
    if (state is CategoriesLoading) notifier.fetchCategories();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eshop Categories'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const CreateCategoryPage()));
        },
        child: const Icon(Icons.add),
      ),
      body: state is CategoriesLoaded
          ? ListView(
              children: state.categories.categories
                  .map((category) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
                        child: CategoryPreview(
                          category,
                          onDelete: () => notifier.deleteCategory(category.id),
                          onEdit: () => () {},
                        ),
                      ))
                  .toList(),
            )
          : const LoadingIndicator(),
    );
  }
}
