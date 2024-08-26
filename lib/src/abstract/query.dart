import 'package:dart_mediatr/src/abstract/request.dart';

/**
 * Represents a query that returns a response.
 * All queries in your project should implement this class to be taken by handlers.
 * @param TResponse The type of the response of the query.
 */
abstract class IQuery<TResponse> extends IRequest<TResponse> {}
