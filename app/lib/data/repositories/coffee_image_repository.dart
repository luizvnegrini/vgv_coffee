import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/foundation.dart';

import '../../domain/domain.dart';
import '../datasource/datasource.dart';

class CoffeeImageRepositoryImpl implements CoffeeImageRepository {
  final String _albumName = 'coffee';

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

  @override
  Future<Either<Exception, List<String>>> loadAlbum() async {
    try {
      final images = await datasource.loadAlbum(_albumName);
      return Right(images);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<Exception, Unit>> saveImage((Uint8List, String) data) async {
    try {
      await datasource.saveImage(
        albumName: _albumName,
        data: data,
      );

      return Right(unit);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
