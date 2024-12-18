import 'package:http/http.dart' as http;

class HttpInstance {
  static final HttpInstance _instance = HttpInstance._internal();
  final http.Client client = http.Client();

  factory HttpInstance() {
    return _instance;
  }

  HttpInstance._internal();
}
