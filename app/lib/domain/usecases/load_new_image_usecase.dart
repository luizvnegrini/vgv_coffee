import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/foundation.dart';

import '../domain.dart';

abstract class LoadNewImageUsecase {
  Future<Either<Exception, (Uint8List, String)>> call();
}

class LoadNewImageUsecaseImpl implements LoadNewImageUsecase {
  final CoffeeImageRepository repository;

  LoadNewImageUsecaseImpl({
    required this.repository,
  });

  @override
  Future<Either<Exception, (Uint8List, String)>> call() async {
    return repository.loadNewImage();
  }
}
