import "package:rick_morty_paginate/datasources/api/resource/ClientErrors.dart";
import "package:rick_morty_paginate/datasources/api/resource/ServerErrors.dart";
import "package:rick_morty_paginate/datasources/api/resource/Success.dart";

abstract class Resource<T> {
  factory Resource.loading(T value) = Loading<T>;

  factory Resource.success(T value) = Success<T>;

  factory Resource.created() = Created<T>;

  factory Resource.noContent() = NoContent<T>;

  factory Resource.nonGenericError(int statusCode) = NonGenericError<T>;

  factory Resource.error(int statusCode, String message) = Error<T>;

  //Client errors
  factory Resource.badRequest() = BadRequest<T>;

  factory Resource.unauthorized() = Unauthorized<T>;

  factory Resource.paymentRequired() = PaymentRequired<T>;

  factory Resource.forbidden() = Forbidden<T>;

  factory Resource.notFound() = NotFound<T>;

  factory Resource.methodNotAllowed() = MethodNotAllowed<T>;

  factory Resource.notAcceptable() = NotAcceptable<T>;

  factory Resource.proxyAuthenticationRequired() =
      ProxyAuthenticationRequired<T>;

  factory Resource.requestTimeout() = RequestTimeout<T>;

  factory Resource.conflict() = Conflict<T>;

  factory Resource.gone() = Gone<T>;

  factory Resource.lengthRequired() = LengthRequired<T>;

  factory Resource.preconditionFailed() = PreconditionFailed<T>;

  factory Resource.payloadTooLarge() = PayloadTooLarge<T>;

  factory Resource.uriTooLong() = URITooLong<T>;

  factory Resource.unsupportedMediaType() = UnsupportedMediaType<T>;

  factory Resource.requestedRangeNotSatisfiable() =
      RequestedRangeNotSatisfiable<T>;

  factory Resource.expectationFailed() = ExpectationFailed<T>;

  factory Resource.imATeapot() = ImATeapot<T>;

  factory Resource.incorrectPassword() = IncorrectPassword<T>;

  factory Resource.misdirectedRequest() = MisdirectedRequest<T>;

  factory Resource.unprocessableEntity() = UnprocessableEntity<T>;

  factory Resource.locked() = Locked<T>;

  factory Resource.failedDependency() = FailedDependency<T>;

  factory Resource.upgradeRequired() = UpgradeRequired<T>;

  factory Resource.preconditionRequired() = PreconditionRequired<T>;

  factory Resource.tooManyRequests() = TooManyRequests<T>;

  factory Resource.requestHeaderFieldsTooLarge() =
      RequestHeaderFieldsTooLarge<T>;

  factory Resource.unavailableForLegalReasons() = UnavailableForLegalReasons<T>;

  //Server errors
  factory Resource.internalServerError() = InternalServerError<T>;

  factory Resource.notImplemented() = NotImplemented<T>;

  factory Resource.badGateway() = BadGateway<T>;

  factory Resource.serviceUnavailable() = ServiceUnavailable<T>;

  factory Resource.gatewayTimeout() = GatewayTimeout<T>;

  factory Resource.httpVersionNotSupported() = HTTPVersionNotSupported<T>;

  factory Resource.variantAlsoNegotiates() = VariantAlsoNegotiates<T>;

  factory Resource.insufficientStorage() = InsufficientStorage<T>;

  factory Resource.loopDetected() = LoopDetected<T>;

  factory Resource.notExtended() = NotExtended<T>;

  factory Resource.networkAuthenticationRequired() =
      NetworkAuthenticationRequired<T>;

  factory Resource.internetNotAvailable() = InternetNotAvailable<T>;

  factory Resource.remoteNotAvailable() = RemoteNotAvailable<T>;
}

class Loading<T> implements Resource<T> {
  final T value;

  const Loading(this.value);
}

class Success<T> implements Resource<T> {
  final T value;

  const Success(this.value);
}

class NonGenericError<T> implements Resource<T> {
  final int statusCode;

  const NonGenericError(this.statusCode);
}

class Error<T> implements Resource<T> {
  final int statusCode;
  final String message;

  const Error(this.statusCode, this.message);
}
