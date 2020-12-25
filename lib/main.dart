import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:meditations_tracker/app/app_initializer.dart';
import 'package:meditations_tracker/app/app_widget.dart';
import 'package:meditations_tracker/logging/logger_extensions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final locator = GetIt.I;
  final config = Configuration();
  final appInitializer = AppInitializer(config);
  appInitializer.initSync(locator);

  final Logger logger = locator();

  logger.fine('app started');
  runZonedGuarded<Future<void>>(
    () async => runApp(AppWidget.create(locator)),
    logger.exceptionReporter('main, runZoned()'),
  );
}
