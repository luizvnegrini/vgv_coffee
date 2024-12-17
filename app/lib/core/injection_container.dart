import 'package:external_dependencies/external_dependencies.dart';

import '../domain/domain.dart';

final _instance = GetIt.instance;

void setupDependencyInjectionContainer() {
  _setupDomain();
}

void _setupDomain() {
  // Usecases
  _instance
      .registerLazySingleton<SaveImageUsecase>(() => SaveImageUsecaseImpl());
  _instance.registerLazySingleton<GetPermissionUsecase>(
      () => GetPermissionUsecaseImpl());
}
