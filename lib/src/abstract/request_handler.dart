import 'package:mediator/src/abstract/request.dart';

abstract class RequestHandler<TRequest extends Request<TResponse>, TResponse> {
  TResponse handle(TRequest request);
}