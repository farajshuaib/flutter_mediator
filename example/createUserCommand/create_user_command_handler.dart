import 'package:mediator/mediator.dart';

import 'create_user_command.dart';
import 'create_user_command_response.dart';



part 'create_user_command_handler.g.dart';

@Handler()
class CreateUserCommandHandler
    implements CommandHandler<CreateUserCommand, CreateUserCommandResponse> {
  @override
  CreateUserCommandResponse handle(CreateUserCommand command) {
    print('User ${command.name} created.');
    return CreateUserCommandResponse();
  }
}
