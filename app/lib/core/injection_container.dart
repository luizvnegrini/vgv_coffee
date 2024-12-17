import 'package:external_dependencies/external_dependencies.dart';

import '../domain/domain.dart';

final _instance = GetIt.instance;

// Função para registrar as dependências
Future<void> initDependencyInjectionContainer() async {
  _instance
      .registerLazySingleton<SaveImageUsecase>(() => SaveImageUsecaseImpl());
}
