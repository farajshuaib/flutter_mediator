import 'package:analyzer/dart/constant/value.dart';
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
      print('Scanning file: ${input.uri}');

      LibraryElement library;
      try {
        library = await buildStep.resolver.libraryFor(input);
      } catch (e) {
        print('Skipping ${input.uri} as it could not be resolved as a Dart library.');
        continue;
      }

      // Skip part files by checking if `partOfLibrary` is not null
      if (library.parts.isNotEmpty) {
        print('Skipping ${input.uri} because it is a part file.');
        continue;
      }

      final libraryReader = LibraryReader(library);
      print('Resolved library for: ${input.uri}');

      bool hasAnnotations = false;

      // Check all classes in the library
      for (var classElement in libraryReader.classes) {
        final className = classElement.name;
        final importPath = input.uri.toString();

        // Check if the class has any annotations
        final annotations = classElement.metadata.map((meta) => meta.computeConstantValue()).whereType<DartObject>();

        bool isRelevantAnnotation = false;

        // Check for CommandHandler annotation
        if (TypeChecker.fromRuntime(CommandHandler).hasAnnotationOfExact(classElement)) {
          isRelevantAnnotation = true;
          print('Found CommandHandler: $className in $importPath');
          commandHandlers.add(className);
          imports.add('import \'$importPath\';');
        }
        // Check for QueryHandler annotation
        else if (TypeChecker.fromRuntime(QueryHandler).hasAnnotationOfExact(classElement)) {
          isRelevantAnnotation = true;
          print('Found QueryHandler: $className in $importPath');
          queryHandlers.add(className);
          imports.add('import \'$importPath\';');
        }
        // Check for RequestHandler annotation
        else if (TypeChecker.fromRuntime(RequestHandler).hasAnnotationOfExact(classElement)) {
          isRelevantAnnotation = true;
          print('Found RequestHandler: $className in $importPath');
          requestHandlers.add(className);
          imports.add('import \'$importPath\';');
        }

        // Skip this class if it has an irrelevant annotation
        if (!isRelevantAnnotation && annotations.isNotEmpty) {
          print('Skipping $className in $importPath due to irrelevant annotations.');
          continue;
        }

        hasAnnotations = hasAnnotations || isRelevantAnnotation;
      }

      if (!hasAnnotations) {
        print('No relevant annotated classes found in ${input.uri}, skipping file.');
        continue;
      }
    }

    if (commandHandlers.isEmpty &&
        queryHandlers.isEmpty &&
        requestHandlers.isEmpty) {
      print('No annotated handlers found in any files.');
    }

    // Add imports
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
