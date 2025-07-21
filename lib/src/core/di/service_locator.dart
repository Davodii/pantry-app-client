import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pantry_app/src/core/api/api_constants.dart';
import 'package:pantry_app/src/core/data/datasources/product_api_datasource.dart';

// Dependency injection setup

final locator = GetIt.instance;

void setupLocator() {
  // 1. register DIO as a singleton
  // ensure only one instance is present at any time
  locator.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    ),
  );

  // Register data sources
  locator.registerLazySingleton(() => ProductApiDatasource(locator<Dio>()));

  // TODO: add more datasources as they are implemented here
}
