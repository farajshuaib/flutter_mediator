# Dart dart_mediatr Package

The Dart mediatr package provides an implementation of the mediator pattern for Dart inspired by MediatR ASP.NET Core, including dynamic handler
registration via code generation. This pattern is useful for organizing your application's commands and queries by
centralizing their processing through a mediator.

The mediator pattern is a behavioral design pattern that centralizes request handling and execution. It promotes loose
coupling between components by removing direct dependencies between them. Instead of components communicating directly
with each other, they communicate through a mediator object. This allows for more flexible and maintainable code, as
components can be easily added, removed, or modified without affecting other components.


## Features

- mediator Pattern: Centralizes request handling and execution.
- Dynamic Handler Registration: Automatically registers handlers using code generation.
- CQRS Support: Facilitates separation of commands (state changes) and queries (data retrieval).
- Command and Query Handlers: Supports both command and query handlers.
- Handler Annotations: Use annotations to auto-register handlers using code generation.
- Handler Registration: Manually register handlers using the `registerCommandHandler` and `registerQueryHandler`
  methods.
- Handler Interface: Implement the `CommandHandler` and `QueryHandler` interfaces to create custom handlers.

## Getting Started

## Installation

To use the dart_mediatr package, add it to your `pubspec.yaml`:

```yaml
dependencies:
  dart_mediatr: ^1.0.0
```

Then, run dart pub get to install the package.

## Usage

To use the dart_mediatr package, you need to create a `dart_mediatr` instance and register your handlers. The `dart_mediatr` class
is the central component that processes requests and routes them to the appropriate handler.

you can register handlers using the `registerCommandHandler` and `registerQueryHandler` methods.
or using the `Handler` annotation to auto register handlers using code generation.

#### To automatically register handlers, use the `build_runner` package. Add the package to your `dev_dependencies` in

`pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.0.0
```

then add the `Handler` annotation to your handler classes:

```dart
import 'package:dart_mediatr/dart_mediatr.dart';

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

then add the `@dart_mediatrInit()` annotation to your main function:

```dart
import 'package:dart_mediatr/dart_mediatr.dart';

@dart_mediatrInit()
void main() async {
  registerAllHandlers();

  runApp(const MyApp());
}
```

Then, run the build_runner to generate the registration code:

```bash
dart run build_runner build
```

then import the generated file in your main file and invoke the `registerAllHandlers` function:

```dart
import 'main.dart_mediatr.dart';

@dart_mediatrInit()
Future<void> main() async {
  registerAllHandlers();

  runApp(const MyApp());
}
```

#### if you hate generated code and you want to manually register handlers, use the `registerCommandHandler` and
`registerQueryHandler` methods:

```dart
import 'package:dart_mediatr/dart_mediatr.dart';

void main() async {
  dart_mediatr dart_mediatr = dart_mediatr();

  dart_mediatr.registerCommandHandler(CreateUserCommandHandler());

  runApp(const MyApp());
}

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


