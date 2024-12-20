import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/foundation.dart';

abstract class CoffeeImageRepository {
  Future<Either<Exception, (Uint8List, String)>> loadNewImage();
  Future<Either<Exception, Unit>> saveImage((Uint8List, String) data);
  Future<Either<Exception, List<String>>> loadAlbum();
}
