# Dart Mediator Package

The Dart Mediator package provides an implementation of the Mediator pattern for Dart, including dynamic handler
registration via code generation. This pattern is useful for organizing your application's commands and queries by
centralizing their processing through a mediator.

## Features

- Mediator Pattern: Centralizes request handling and execution.
- Dynamic Handler Registration: Automatically registers handlers using code generation.
- CQRS Support: Facilitates separation of commands (state changes) and queries (data retrieval).

## Installation

To use the Dart Mediator package, add it to your `pubspec.yaml`:

```yaml
dependencies:
  mediator: ^0.0.1
```

Then, run dart pub get to install the package.

## Usage

### Setup

To use the Mediator package, you need to create a `Mediator` instance and register your handlers. The `Mediator` class
is the central component that processes requests and routes them to the appropriate handler.

### Define Command and Handlers

Create your requests (commands and queries) and their corresponding handlers. Use the @Handler annotation to mark
handler classes.

```dart
import 'package:mediator/mediator.dart';
import 'create_user_command_response.dart';


class CreateUserCommand extends Command<CreateUserCommandResponse> {
  final String name;
  final String email;

  CreateUserCommand(this.name, this.email);
}

```

```dart
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

```

```dart

class CreateUserCommandResponse {


  CreateUserCommandResponse();
}

```

### Register Handlers

there's two ways to register handlers:

- via annotation :

```dart
import 'package:mediator/mediator.dart';
import 'create_user_command.dart';
import 'create_user_command_response.dart';

@Handler()
class CreateUserCommandHandler
    implements CommandHandler<CreateUserCommand, CreateUserCommandResponse> {
  @override
  CreateUserCommandResponse handle(CreateUserCommand command) {
    print('User ${command.name} created.');
    return CreateUserCommandResponse();
  }
}
```

- via mediator instance registration method :

```dart
import 'package:mediator/mediator.dart';

void main() {
  final mediator = Mediator();

  // Register handlers
  mediator.registerCommandHandler(CreateUserCommandHandler());

  // Send command
  final result =
  mediator.sendCommand(CreateUserCommand('faraj', 'farajshuaib@gmail.com'));

  print(result);
}
```

### Code Generation

To automatically register handlers, use the `mediator_generator` package. Add the package to your `dev_dependencies` in
`pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.0.0
```

Then, run the build_runner to generate the registration code:

```bash
dart run build_runner build
```

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Run the tests (`dart test`).
5. Commit your changes (`git commit -am 'Add new feature'`).
6. Push to the branch (`git push origin feature-branch`).
7. Create a new Pull Request.
8. Get your changes reviewed.

## License

This package is licensed under the MIT License. See the LICENSE file for details.


