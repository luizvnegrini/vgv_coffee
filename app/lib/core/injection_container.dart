import 'package:external_dependencies/external_dependencies.dart';

import '../adapters/adapters.dart';
import '../data/data.dart';
import '../data/datasource/datasource.dart';
import '../domain/domain.dart';

final _instance = GetIt.instance;

void setupDependencyInjectionContainer() {
  _setupDomain();
}

void _setupDomain() {
  // Adapters
  _instance.registerLazySingleton<HttpAdapter>(
    () => HttpAdapterImpl(
      HttpInstance(),
    ),
  );

  // Datasources
  _instance.registerLazySingleton<CoffeeImageDatasource>(
      () => CoffeeImageDatasourceImpl(httpClient: _instance()));

  // Repositories
  _instance.registerLazySingleton<CoffeeImageRepository>(
      () => CoffeeImageRepositoryImpl(datasource: _instance()));

  // Usecases
  _instance
    ..registerLazySingleton<LoadNewImageUsecase>(
      () => LoadNewImageUsecaseImpl(repository: _instance()),
    )
    ..registerLazySingleton<SaveImageUsecase>(() => SaveImageUsecaseImpl())
    ..registerLazySingleton<GetPermissionUsecase>(
      () => GetPermissionUsecaseImpl(),
    )
    ..registerLazySingleton<LoadCoffeeAlbumUsecase>(
      () => LoadCoffeeAlbumUsecaseImpl(),
    );
}
