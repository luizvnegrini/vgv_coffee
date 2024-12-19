import 'package:flutter/foundation.dart';

import '../../domain/domain.dart';

abstract class CoffeeImageDatasource {
  Future<(Uint8List, String)> loadNewImage();
}

class CoffeeImageDatasourceImpl implements CoffeeImageDatasource {
  final HttpAdapter httpClient;

  CoffeeImageDatasourceImpl({
    required this.httpClient,
  });

  @override
  Future<(Uint8List, String)> loadNewImage() async {
    final response = await httpClient.downloadImage(
      'https://coffee.alexflipnote.dev/random',
    );

    return response;
  }
}
