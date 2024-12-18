import 'package:flutter/foundation.dart';

abstract class HttpAdapter {
  Future<Uint8List> downloadImage(String url);
}
