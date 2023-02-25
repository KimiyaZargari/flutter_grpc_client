import 'package:flutter_grpc_client/infrastructure/category/categories_repository.dart';
import 'package:flutter_grpc_client/infrastructure/core/client.dart';
import 'package:flutter_grpc_client/infrastructure/core/core_repository.dart';
import 'package:flutter_grpc_client/presentation/category/notifiers/categories_notifier.dart';
import 'package:flutter_grpc_client/presentation/category/notifiers/create_category_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesRepositoryProvider =
    Provider((ref) => CategoriesRepository(ref.watch(clientProvider)));

final categoriesProvider =
    StateNotifierProvider.autoDispose<CategoriesNotifier, CategoriesState>(
        (ref) => CategoriesNotifier(
            repository: ref.watch(categoriesRepositoryProvider)));
final createCategoryProvider = StateNotifierProvider.autoDispose<
        CreateCategoryNotifier, CreateCategoryState>(
    (ref) => CreateCategoryNotifier(
        categoryRepository: ref.watch(categoriesRepositoryProvider),
        coreRepository: ref.watch(coreRepositoryProvider)));
