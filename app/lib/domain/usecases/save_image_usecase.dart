import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/services.dart';

import '../domain.dart';

abstract class SaveImageUsecase {
  Future<Either<Exception, Unit>> call((Uint8List, String) data);
}

class SaveImageUsecaseImpl implements SaveImageUsecase {
  final CoffeeImageRepository repository;

  SaveImageUsecaseImpl({required this.repository});

  @override
  Future<Either<Exception, Unit>> call((Uint8List, String) data) async {
    return await repository.saveImage(data);
  }
}
