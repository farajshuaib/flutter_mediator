import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'handler_generator.dart';

Builder handlerBuilder(BuilderOptions options) =>
    LibraryBuilder(HandlerGenerator(), generatedExtension: '.mediator.dart');
