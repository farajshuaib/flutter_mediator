import 'command.dart';

abstract class CommandHandler<TCommand extends Command<TResponse>, TResponse> {
  TResponse handle(TCommand command);
}

