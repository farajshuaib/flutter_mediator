import 'dart_mediatr.dart';

export 'src/abstract/index.dart';
export 'src/annotations.dart';

class Mediator {
  static final Mediator _instance = Mediator._internal();

  Mediator._internal();

  factory Mediator() {
    return _instance;
  }

  final Map<Type, dynamic> _handlers = {};

  void registerRequestHandler<TRequest extends Request<TResponse>, TResponse>(
      RequestHandler<TRequest, TResponse> handler) {
    _handlers[TRequest] = handler;
  }

  void registerCommandHandler<TCommand extends Command<TResponse>, TResponse>(
      CommandHandler<TCommand, TResponse> handler) {
    _handlers[TCommand] = handler;
  }

  void registerQueryHandler<TQuery extends Query<TResponse>, TResponse>(
      QueryHandler<TQuery, TResponse> handler) {
    _handlers[TQuery] = handler;
  }

  TResponse send<TRequest extends Request<TResponse>, TResponse>(
      TRequest request) {
    final handler = _handlers[TRequest];
    if (handler == null) {
      throw Exception('No handler registered for $TRequest');
    }
    return handler.handle(request);
  }

  TResponse sendCommand<TCommand extends Command<TResponse>, TResponse>(
      TCommand command) {
    final handler = _handlers[TCommand];
    if (handler == null) {
      throw Exception('No handler registered for $TCommand');
    }
    return handler.handle(command);
  }

  TResponse sendQuery<TQuery extends Query<TResponse>, TResponse>(
      TQuery query) {
    final handler = _handlers[TQuery];
    if (handler == null) {
      throw Exception('No handler registered for $TQuery');
    }
    return handler.handle(query);
  }
}
