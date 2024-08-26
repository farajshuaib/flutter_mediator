// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// MediatorGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:example/createUserCommand/create_user_command_handler.dart';

Mediator mediator = Mediator();

void registerCommandHandlers() {
  mediator.registerCommandHandler(CreateUserCommandHandler());
}

void registerQueryHandlers() {}

void registerRequestHandlers() {}

void registerAllHandlers() {
  registerCommandHandlers();
  registerQueryHandlers();
  registerRequestHandlers();
}
