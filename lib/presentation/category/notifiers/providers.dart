import 'package:flutter_grpc_client/presentation/category/notifiers/categories_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>(
        (ref) => CategoriesNotifier());
