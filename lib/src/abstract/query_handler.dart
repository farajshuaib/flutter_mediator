import 'package:dart_mediatr/src/abstract/query.dart';

abstract class QueryHandler<TQuery extends Query<TResponse>, TResponse> {
  TResponse handle(TQuery query);
}
