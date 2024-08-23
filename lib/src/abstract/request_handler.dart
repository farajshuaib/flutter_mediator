import 'package:dart_mediatr/src/abstract/request.dart';

abstract class RequestHandler<TRequest extends Request<TResponse>, TResponse> {
  TResponse handle(TRequest request);
}