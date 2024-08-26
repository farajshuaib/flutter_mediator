import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:example/createUserCommand/create_user_command_response.dart';

class CreateUserCommand extends ICommand<CreateUserCommandResponse> {
  final String name;
  final String email;

  CreateUserCommand(this.name, this.email);
}
