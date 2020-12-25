import 'package:logging/logging.dart';

typedef ExceptionFunction = Function(dynamic exception, StackTrace stack);

extension LoggerExt on Logger {
  ExceptionFunction exceptionReporter(String message) {
    return (dynamic exception, StackTrace stack) {
      severe(message, exception as Object, stack);
    };
  }
}
