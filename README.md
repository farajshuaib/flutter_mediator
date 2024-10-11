# 🐦 Dart Mediator Package

The **Dart Mediator** package provides an implementation of the **Mediator** pattern for Dart, inspired by **MediatR** from ASP.NET Core. It includes dynamic handler registration via code generation. This pattern is useful for organizing your application's commands and queries by centralizing their processing through a mediator. 
Read more about the Mediator pattern [here](https://dev.to/farajshuaib/understanding-the-mediator-pattern-and-cqrs-with-dartmediatr-2aj7).

## 🚀 Features
- 🔄 **Dynamic Handler Registration:** Automatically registers handlers using code generation.
- 📊 **CQRS Support:** Facilitates separation of commands (state changes) and queries (data retrieval).
- ✋ **Command and Query Handlers:** Supports both command and query handlers.
- 🏷️ **Handler Annotations:** Use annotations `CommandHandler`, `QueryHandler`, and `RequestHandler` to auto-register handlers using code generation.
- 📜 **Handler Registration:** Manually register handlers using the `registerCommandHandler` and `registerQueryHandler` methods.

## 📦 Getting Started

### Installation

To use the Dart Mediator package, add it to your `pubspec.yaml`:

```yaml
dependencies:
  dart_mediatr: ^1.0.5
```

Then, run `dart pub get` to install the package.

### Usage

To use the Mediator package, create a `Mediator` instance and register your handlers. 
The `Mediator` class is the central component that processes requests and routes them to the appropriate handler.

You can register handlers using the `registerCommandHandler` and `registerQueryHandler` methods, or by using the `CommandHandler` and `QueryHandler` annotations to auto-register handlers via code generation.

#### 🔧 Automatically Register Handlers
To automatically register handlers, use the `build_runner` package. Add it to your `dev_dependencies` in `pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.0.0
```

## 📝 Example
Create a command to create a user:

```dart
import 'package:dart_mediatr/dart_mediatr.dart';

class CreateUserCommand extends ICommand<CreateUserCommandResponse> {
  final String name;
  final String email;

  CreateUserCommand(this.name, this.email);
}
```

```dart
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
```

```dart
class CreateUserCommandResponse {
  final String id;
  final String name;
  final String email;

  CreateUserCommandResponse({
    required this.id,
    required this.name,
    required this.email,
  });
}
```

Then, add the `@MediatorInit()` annotation to your main function to generate the registration code:

```dart
import 'package:dart_mediatr/dart_mediatr.dart';

@MediatorInit()
void main() async {
  runApp(const MyApp());
}
```

Now, run the build_runner to generate the registration code:

```bash
dart run build_runner build
```

Then import the generated file in your main file and invoke the `registerAllHandlers` function:

```dart
import 'package:dart_mediatr/dart_mediatr.dart';
import 'main.mediator.dart';

@MediatorInit()
Future<void> main() async {
  registerAllHandlers();
  runApp(const MyApp());
}
```

Finally, use the `Mediator` class to send commands and queries:

```dart
void main() async {
  Mediator mediator = Mediator();
  CreateUserCommand command = CreateUserCommand('faraj shuaib', 'farajshuaib@gmail.com');
  CreateUserCommandResponse response = mediator.sendCommand<CreateUserCommand, CreateUserCommandResponse>(command);
}
```

### 🔧 Manual Handler Registration
If you prefer to manually register handlers, use the `registerCommandHandler` and `registerQueryHandler` methods:

```dart
import 'package:dart_mediatr/dart_mediatr.dart';

void main() async {
  Mediator mediator = Mediator();
  mediator.registerCommandHandler(CreateUserCommandHandler());
  runApp(const MyApp());
}
```

You can then use the `Mediator` class to send commands and queries as shown above.

## 🤝 Contributing

Contributions are welcome! Please follow these steps to contribute:

1. 🍴 Fork the repository.
2. 🌳 Create a new branch (`git checkout -b feature-branch`).
3. ✏️ Make your changes.
4. 🧪 Run the tests (`dart test`).
5. 💾 Commit your changes (`git commit -am 'Add new feature'`).
6. 🚀 Push to the branch (`git push origin feature-branch`).
7. 🔄 Create a new Pull Request.
8. ✅ Get your changes reviewed.

## 📝 License

This package is licensed under the MIT License. See the LICENSE file for details.

