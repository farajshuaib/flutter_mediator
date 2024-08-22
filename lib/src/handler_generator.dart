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
    final typeName =
        classElement.supertype?.getDisplayString(withNullability: false);

    // get file name from class name
    final fileName = classElement.name.toLowerCase();

    if (typeName == null) {
      throw Exception('Class must extend a handler interface.');
    }

    return '''
    // GENERATED CODE - DO NOT MODIFY BY HAND

    // ignore_for_file: unused_element, unused_import, unnecessary_import
    
    part of '${fileName}.dart';
    
    import 'package:mediator/mediator.dart';
    
    final mediator = Mediator();
    
    // Generated code
    final handler = $className();
    mediator.register${typeName.replaceAll('Handler', '')}Handler(handler);
    ''';
  }
}
