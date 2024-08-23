import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'annotations.dart';

class MediatorGenerator extends GeneratorForAnnotation<MediatorInit> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    final buffer = StringBuffer();

    final fileName =
        buildStep.inputId.pathSegments.last.replaceAll('.dart', '');

    buffer.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    buffer.writeln('import \'package:mediator/mediator.dart\';');

    final handlers = <String>[];
    final imports = <String>{};

    await for (var input in buildStep.findAssets(Glob('lib/**/*.dart'))) {
      final library = LibraryReader(await buildStep.resolver.libraryFor(input));

      for (var annotatedElement
          in library.annotatedWith(TypeChecker.fromRuntime(Handler))) {
        final classElement = annotatedElement.element as ClassElement;
        final className = classElement.name;
        final importPath = input.uri.toString();

        imports.add('import \'$importPath\';');
        handlers.add(className);
      }
    }

    imports.forEach(buffer.writeln);

    buffer.write('Mediator mediator = Mediator(); \n\n');

    // Generate the registerAllHandlers function
    buffer.writeln('\n\n\nvoid registerAllHandlers() {');
    for (var handler in handlers) {
      if (handler.contains('CommandHandler')) {
        buffer.writeln('\t mediator.registerCommandHandler($handler());');
      }

      if (handler.contains('QueryHandler')) {
        buffer.writeln('\t mediator.registerQueryHandler($handler());');
      }

      if (handler.contains('RequestHandler')) {
        buffer.writeln('\t mediator.registerRequestHandler($handler());');
      }
    }
    buffer.writeln('} \n');

    return buffer.toString();
  }
}

Builder mediatorInitBuilder(BuilderOptions options) => LibraryBuilder(
      MediatorGenerator(),
      generatedExtension: '.mediator.dart',
    );
