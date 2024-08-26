import 'command.dart';

/**
 * Represents a command handler that returns a response.
 * Here you should implement the logic of the command.
 * All command handlers in your project should implement this class.
 * @param TCommand The type of the command to handle.
 * @param TResponse The type of the response of the command.
 */
abstract class ICommandHandler<TCommand extends ICommand<TResponse>, TResponse> {
  TResponse handle(TCommand command);
}

