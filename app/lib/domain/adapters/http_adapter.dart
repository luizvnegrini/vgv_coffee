import 'package:flutter/foundation.dart';

abstract class HttpAdapter {
  Future<(Uint8List, String)> downloadImage(String url);
}
