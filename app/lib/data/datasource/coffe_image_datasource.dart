import 'package:flutter/foundation.dart';

import '../../domain/domain.dart';

abstract class CoffeeImageDatasource {
  Future<(Uint8List, String)> loadNewImage();
  Future<List<String>> loadAlbum(String albumName);
  Future<void> saveImage({
    required String albumName,
    required (Uint8List, String) data,
  });
}

class CoffeeImageDatasourceImpl implements CoffeeImageDatasource {
  final HttpAdapter httpClient;
  final PhotoStorageAdapter photoStorageAdapter;

  CoffeeImageDatasourceImpl({
    required this.httpClient,
    required this.photoStorageAdapter,
  });

  @override
  Future<(Uint8List, String)> loadNewImage() async {
    final response = await httpClient.downloadImage(
      'https://coffee.alexflipnote.dev/random',
    );

    return response;
  }

  @override
  Future<List<String>> loadAlbum(String albumName) async {
    return await photoStorageAdapter.loadAlbum(albumName);
  }

  @override
  Future<void> saveImage({
    required String albumName,
    required (Uint8List, String) data,
  }) async {
    return await photoStorageAdapter.saveImage(
      albumName: albumName,
      data: data,
    );
  }
}
