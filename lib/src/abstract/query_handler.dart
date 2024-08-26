import 'package:dart_mediatr/src/abstract/query.dart';

abstract class IQueryHandler<TQuery extends IQuery<TResponse>, TResponse> {
  TResponse handle(TQuery query);
}
