import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/foundation.dart';

import '../../domain/domain.dart';
import '../datasource/datasource.dart';

class CoffeeImageRepositoryImpl implements CoffeeImageRepository {
  final CoffeeImageDatasource datasource;

  CoffeeImageRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Exception, (Uint8List, String)>> loadNewImage() async {
    try {
      final image = await datasource.loadNewImage();
      return Right(image);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
