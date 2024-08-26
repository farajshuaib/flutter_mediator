import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

class MediatorGenerator extends GeneratorForAnnotation<MediatorInit> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final buffer = StringBuffer();

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('import \'package:dart_mediatr/dart_mediatr.dart\';');

    final commandHandlers = <String>[];
    final queryHandlers = <String>[];
    final requestHandlers = <String>[];
    final imports = <String>{};

    await for (var input in buildStep.findAssets(Glob('lib/**/*.dart'))) {
      final library = LibraryReader(await buildStep.resolver.libraryFor(input));

      // Find all classes annotated with CommandHandler
      for (var annotatedElement
          in library.annotatedWith(TypeChecker.fromRuntime(CommandHandler))) {
        final classElement = annotatedElement.element as ClassElement;
        final className = classElement.name;
        final importPath = input.uri.toString();

        imports.add('import \'$importPath\';');
        commandHandlers.add(className);
      }

      // Find all classes annotated with QueryHandler
      for (var annotatedElement
          in library.annotatedWith(TypeChecker.fromRuntime(QueryHandler))) {
        final classElement = annotatedElement.element as ClassElement;
        final className = classElement.name;
        final importPath = input.uri.toString();

        imports.add('import \'$importPath\';');
        queryHandlers.add(className);
      }

      // Find all classes annotated with RequestHandler
      for (var annotatedElement
          in library.annotatedWith(TypeChecker.fromRuntime(RequestHandler))) {
        final classElement = annotatedElement.element as ClassElement;
        final className = classElement.name;
        final importPath = input.uri.toString();

        imports.add('import \'$importPath\';');
        requestHandlers.add(className);
      }
    }

    imports.forEach(buffer.writeln);

    buffer.write('Mediator mediator = Mediator(); \n\n');

    // Generate the registerCommandHandlers function
    buffer.writeln('void registerCommandHandlers() {');
    for (var handler in commandHandlers) {
      buffer.writeln('\t mediator.registerCommandHandler($handler());');
    }
    buffer.writeln('} \n');

    // Generate the registerQueryHandlers function
    buffer.writeln('void registerQueryHandlers() {');
    for (var handler in queryHandlers) {
      buffer.writeln('\t mediator.registerQueryHandler($handler());');
    }
    buffer.writeln('} \n');

    // Generate the registerRequestHandlers function
    buffer.writeln('void registerRequestHandlers() {');
    for (var handler in requestHandlers) {
      buffer.writeln('\t mediator.registerRequestHandler($handler());');
    }
    buffer.writeln('} \n');

    // Generate the registerAllHandlers function
    buffer.writeln('\n\n\nvoid registerAllHandlers() {');
    buffer.writeln('\t registerCommandHandlers();');
    buffer.writeln('\t registerQueryHandlers();');
    buffer.writeln('\t registerRequestHandlers();');
    buffer.writeln('} \n');

    return buffer.toString();
  }
}

Builder mediatorInitBuilder(BuilderOptions options) => LibraryBuilder(
      MediatorGenerator(),
      generatedExtension: '.mediator.dart',
    );
