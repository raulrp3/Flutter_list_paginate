import "dart:io";

class ClientHttpException extends HttpException {
  int statusCode;
  String message;

  ClientHttpException(this.statusCode, this.message) : super(message);

  @override
  String toString() => "ClientHttpException{statusCode: $statusCode, message: $message}";
}
