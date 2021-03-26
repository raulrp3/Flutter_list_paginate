import 'dart:async';
import "dart:convert";
import 'dart:core';
import 'dart:io';

import "package:http/http.dart";

import "Resource.dart";

typedef S _ToRepo<S>(Map<String, dynamic> obj);

Future<Resource<R>> resourceBuilder<R, S>(Future<Response> futureResponse, _ToRepo<S> toRepo) async {
  try {
    Response response = await futureResponse;
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.contentLength == 0) return Resource<R>.noContent();
      final jsonDecoded = jsonDecode(response.body);
      print("Response: $jsonDecoded");
      if (jsonDecoded is List) {
        final jsonDecoded = jsonDecode(response.body).cast<Map<String, dynamic>>();
        final list = jsonDecoded.map<S>((map) => toRepo(map)).toList();
        return Resource<R>.success(list);
      } else
        return Resource<S>.success(toRepo(jsonDecoded)) as Resource<R>;
    } else {
      switch (response.statusCode) {
        case 201:
          return Resource<R>.created();
        case 204:
          return Resource<R>.noContent();
        default:
          return _errors<R>(response);
      }
    }
  } on TimeoutException {
    return Resource<R>.requestTimeout();
  } on SocketException catch (e) {
    if (e.osError.errorCode == 7 || e.osError.errorCode == 8)
      return Resource<R>.internetNotAvailable();
    else
      return Resource<R>.remoteNotAvailable();
  }
}

Resource<R> _errors<R>(Response response) {
  switch (response.statusCode) {
    //Client errors
    case 400:
      return Resource<R>.badRequest();
    case 401:
      return Resource<R>.unauthorized();
    case 402:
      return Resource<R>.paymentRequired();
    case 403:
      return Resource<R>.forbidden();
    case 404:
      return Resource<R>.notFound();
    case 405:
      return Resource<R>.methodNotAllowed();
    case 406:
      return Resource<R>.notAcceptable();
    case 407:
      return Resource<R>.proxyAuthenticationRequired();
    case 408:
      return Resource<R>.requestTimeout();
    case 409:
      return Resource<R>.conflict();
    case 410:
      return Resource<R>.gone();
    case 411:
      return Resource<R>.lengthRequired();
    case 412:
      return Resource<R>.preconditionFailed();
    case 413:
      return Resource<R>.payloadTooLarge();
    case 414:
      return Resource<R>.uriTooLong();
    case 415:
      return Resource<R>.unsupportedMediaType();
    case 416:
      return Resource<R>.requestedRangeNotSatisfiable();
    case 417:
      return Resource<R>.expectationFailed();
    case 418:
      return Resource<R>.imATeapot();
    case 421:
      return Resource<R>.misdirectedRequest();
    case 422:
      return Resource<R>.unprocessableEntity();
    case 423:
      return Resource<R>.locked();
    case 424:
      return Resource<R>.failedDependency();
    case 426:
      return Resource<R>.upgradeRequired();
    case 428:
      return Resource<R>.preconditionRequired();
    case 429:
      return Resource<R>.tooManyRequests();
    case 431:
      return Resource<R>.requestHeaderFieldsTooLarge();
    case 451:
      return Resource<R>.unavailableForLegalReasons();

    //Server errors
    case 500:
      return Resource<R>.internalServerError();
    case 501:
      return Resource<R>.notImplemented();
    case 502:
      return Resource<R>.badGateway();
    case 503:
      return Resource<R>.serviceUnavailable();
    case 504:
      return Resource<R>.gatewayTimeout();
    case 505:
      return Resource<R>.httpVersionNotSupported();
    case 506:
      return Resource<R>.variantAlsoNegotiates();
    case 507:
      return Resource<R>.insufficientStorage();
    case 508:
      return Resource<R>.loopDetected();
    case 510:
      return Resource<R>.notExtended();
    case 511:
      return Resource<R>.networkAuthenticationRequired();

    default:
      return Resource<R>.nonGenericError(response.statusCode);
  }
}
