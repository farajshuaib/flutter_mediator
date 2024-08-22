import 'package:mediator/mediator.dart';
import 'create_user_command_response.dart';

class CreateUserCommand extends Command<CreateUserCommandResponse> {
  final String name;
  final String email;

  CreateUserCommand(this.name, this.email);
}
