import 'dart_mediatr.dart';

export 'src/abstract/index.dart';
export 'src/annotations.dart';

/// The main class for sending requests, commands, and queries and register handlers.
class Mediator {
  // Singleton
  static final Mediator _instance = Mediator._internal();

  Mediator._internal();

  // factory constructor
  factory Mediator() {
    return _instance;
  }

  // Handlers
  final Map<Type, dynamic> _handlers = {};

  // Register Generic Request handlers
  void registerRequestHandler<TRequest extends IRequest<TResponse>, TResponse>(
      IRequestHandler<TRequest, TResponse> handler) {
    _handlers[TRequest] = handler;
  }


  // Register Command handlers
  void registerCommandHandler<TCommand extends ICommand<TResponse>, TResponse>(
      ICommandHandler<TCommand, TResponse> handler) {
    _handlers[TCommand] = handler;
  }

  // Register Query handlers
  void registerQueryHandler<TQuery extends IQuery<TResponse>, TResponse>(
      IQueryHandler<TQuery, TResponse> handler) {
    _handlers[TQuery] = handler;
  }

  // Send Request, Command, or Query
  TResponse send<TRequest extends IRequest<TResponse>, TResponse>(
      TRequest request) {
    // takes the handler from the map by their request type
    final handler = _handlers[TRequest];
    // if the handler is null, throw an exception
    if (handler == null) {
      throw Exception('No handler registered for $TRequest');
    }
    // handle the request
    return handler.handle(request);
  }

  // Send Command
  TResponse sendCommand<TCommand extends ICommand<TResponse>, TResponse>(
      TCommand command) {
    final handler = _handlers[TCommand];
    if (handler == null) {
      throw Exception('No handler registered for $TCommand');
    }
    return handler.handle(command);
  }

  // Send Query
  TResponse sendQuery<TQuery extends IQuery<TResponse>, TResponse>(
      TQuery query) {
    final handler = _handlers[TQuery];
    if (handler == null) {
      throw Exception('No handler registered for $TQuery');
    }
    return handler.handle(query);
  }
}
