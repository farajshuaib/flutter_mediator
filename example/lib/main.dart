import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:example/createUserCommand/create_user_command_response.dart';

import 'createUserCommand/create_user_command.dart';
import 'main.mediator.dart';

@MediatorInit()
void main() {
  registerAllHandlers();

  var command = CreateUserCommand('faraj shuaib', 'farajshuaib@gmail.com');

  var response = mediator
      .sendCommand<CreateUserCommand, CreateUserCommandResponse>(command);

  print(response.name);
}
