import "Resource.dart";

class InternalServerError<T> implements Resource<T> {
  final int statusCode = 500;
  String message = "Internal Server Error";
}

class NotImplemented<T> implements Resource<T> {
  final int statusCode = 501;
  String message = "Not Implemented";
}

class BadGateway<T> implements Resource<T> {
  final int statusCode = 502;
  String message = "Bad Gateway";
}

class ServiceUnavailable<T> implements Resource<T> {
  final int statusCode = 503;
  String message = "Service Unavailable";
}

class GatewayTimeout<T> implements Resource<T> {
  final int statusCode = 504;
  String message = "Gateway Timeout";
}

class HTTPVersionNotSupported<T> implements Resource<T> {
  final int statusCode = 505;
  String message = "HTTP Version Not Supported";
}

class VariantAlsoNegotiates<T> implements Resource<T> {
  final int statusCode = 506;
  String message = "Variant Also Negotiates";
}

class InsufficientStorage<T> implements Resource<T> {
  final int statusCode = 507;
  String message = "Insufficient Storage";
}

class LoopDetected<T> implements Resource<T> {
  final int statusCode = 508;
  String message = "Loop Detected";
}

class NotExtended<T> implements Resource<T> {
  final int statusCode = 510;
  String message = "Not Extended";
}

class NetworkAuthenticationRequired<T> implements Resource<T> {
  final int statusCode = 511;
  String message = "Network Authentication Required";
}
