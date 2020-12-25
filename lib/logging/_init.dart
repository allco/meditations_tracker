import 'dart:developer' as dev;

import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

void initLocator(GetIt locator) {
  initRootLogger();
  final logger = Logger('log_main');
  locator.registerSingleton(logger);
}

void initRootLogger() {
  final logger = Logger.root;
  logger.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    dev.log(
      (record.loggerName == null ? '' : '${record.loggerName}: ') +
          '${record.message}',
      level: record.level.value,
      time: record.time,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
      sequenceNumber: record.sequenceNumber,
    );
  });
}

Logger createLogger(String loggerName) => Logger(loggerName);
