import 'package:dart_mediatr/src/abstract/request.dart';

/**
 * Represents a request handler that returns a response.
 * Here you should implement the logic of the request.
 * All request handlers in your project should implement this class.
 * @param TRequest The type of the request to handle.
 * @param TResponse The type of the response of the request.
 */
abstract class IRequestHandler<TRequest extends IRequest<TResponse>, TResponse> {
  TResponse handle(TRequest request);
}