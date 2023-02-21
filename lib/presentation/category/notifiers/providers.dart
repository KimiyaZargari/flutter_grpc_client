import 'package:flutter_grpc_client/infrastructure/category/categories_repository.dart';
import 'package:flutter_grpc_client/infrastructure/core/client.dart';
import 'package:flutter_grpc_client/presentation/category/notifiers/categories_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesRepositoryProvider =
    Provider((ref) => CategoriesRepository(ref.watch(clientProvider)));

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) =>
        CategoriesNotifier(
            repository: ref.watch(categoriesRepositoryProvider)));
