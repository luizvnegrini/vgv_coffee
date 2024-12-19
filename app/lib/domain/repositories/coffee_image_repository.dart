import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/foundation.dart';

abstract class CoffeeImageRepository {
  Future<Either<Exception, (Uint8List, String)>> loadNewImage();
}
