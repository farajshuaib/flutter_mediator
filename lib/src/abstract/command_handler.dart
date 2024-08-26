import 'command.dart';

abstract class ICommandHandler<TCommand extends ICommand<TResponse>, TResponse> {
  TResponse handle(TCommand command);
}

