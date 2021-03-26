import "package:http/http.dart";

import 'ClientHttpException.dart';
import 'ServerHttpException.dart';

class ExceptionHandler {
  Response response;

  ExceptionHandler(this.response) {
    if (response.statusCode >= 400 && response.statusCode < 500)
      throw ClientHttpException(response.statusCode, response.body);
    else if (response.statusCode >= 500 && response.statusCode < 600)
      throw ServerHttpException(response.statusCode, response.body);

    throw Exception("Unknown exception");
  }
}
