import 'package:external_dependencies/external_dependencies.dart';
import 'package:flutter/foundation.dart';

import '../domain/domain.dart';

class HttpAdapterImpl implements HttpAdapter {
  final HttpInstance _http;

  HttpAdapterImpl(this._http);

  @override
  Future<Uint8List> downloadImage(String url) async {
    final response = await _http.client.get(
      Uri.parse(url),
    );

    return response.bodyBytes;
  }
}
