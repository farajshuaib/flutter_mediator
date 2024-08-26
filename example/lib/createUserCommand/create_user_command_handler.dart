import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:example/createUserCommand/create_user_command.dart';
import 'package:example/createUserCommand/create_user_command_response.dart';

@CommandHandler()
class CreateUserCommandHandler
    extends ICommandHandler<CreateUserCommand, CreateUserCommandResponse> {
  @override
  CreateUserCommandResponse handle(CreateUserCommand command) {
    return CreateUserCommandResponse(
        id: "", email: command.email, name: command.name);
  }
}
