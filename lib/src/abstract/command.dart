import 'package:dart_mediatr/src/abstract/request.dart';

/**
 * Represents a command that returns a response.
 * All commands in your project should implement this class to be taken by handlers.
 * @param TResponse The type of the response of the command.
 */
abstract class ICommand<TResponse> extends IRequest<TResponse> {}
