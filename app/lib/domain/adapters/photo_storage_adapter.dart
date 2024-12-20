import 'package:flutter/services.dart';

abstract class PhotoStorageAdapter {
  Future<void> saveImage({
    required String albumName,
    required (Uint8List, String) data,
  });

  Future<List<String>> loadAlbum(String albumName);
}
