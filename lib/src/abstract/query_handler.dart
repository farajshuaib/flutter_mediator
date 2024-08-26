import 'package:dart_mediatr/src/abstract/query.dart';

/**
 * Represents a query handler that returns a response.
 * Here you should implement the logic of the query.
 * All query handlers in your project should implement this class.
 * @param TQuery The type of the query to handle.
 * @param TResponse The type of the response of the query.
 */
abstract class IQueryHandler<TQuery extends IQuery<TResponse>, TResponse> {
  TResponse handle(TQuery query);
}
