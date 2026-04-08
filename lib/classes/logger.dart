import 'package:logger/logger.dart';

class AppLogger {
  static final Logger logger = Logger(printer: PrettyPrinter());

  static final Logger loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );
}
