import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:mediator/src/annotations.dart';
import 'package:source_gen/source_gen.dart';

class HandlerGenerator extends GeneratorForAnnotation<Handler> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw Exception('The @Handler annotation can only be used on classes.');
    }

    final classElement = element as ClassElement;
    final className = classElement.name;

    final fileName =
        buildStep.inputId.pathSegments.last.replaceAll('.dart', '');

    bool isCommandHandler = className.contains('CommandHandler');

    bool isQueryHandler = className.contains('QueryHandler');

    bool isRequestHandler = className.contains('RequestHandler');

    return '''
    // GENERATED CODE - DO NOT MODIFY BY HAND

    // ignore_for_file: unused_element, unused_import, unnecessary_import
        
    part of '$fileName.dart';
    
    
    final mediator = Mediator();
    
    // Register the handler
    void _\$registerHandlers(Mediator mediator) {
      final $className handler = $className();
      
      ${isCommandHandler ? 'mediator.registerCommandHandler(handler);' : ''}
      ${isQueryHandler ? 'mediator.registerQueryHandler(handler);' : ''}
      ${isRequestHandler ? 'mediator.registerRequestHandler(handler);' : ''}
      
      
    }
    

    ''';
  }
}
