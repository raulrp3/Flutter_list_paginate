import "dart:io";

class ServerHttpException extends HttpException {
  int statusCode;
  String message;

  ServerHttpException(this.statusCode, this.message) : super(message);

  @override
  String toString() {
    return "ServerHttpException{statusCode: $statusCode, message: $message}";
  }
}
