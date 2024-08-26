import 'package:dart_mediatr/src/abstract/request.dart';

abstract class IRequestHandler<TRequest extends IRequest<TResponse>, TResponse> {
  TResponse handle(TRequest request);
}