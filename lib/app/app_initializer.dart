import 'package:flutter/foundation.dart' as flutter_foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:meditations_tracker/app/app_style.dart';
import 'package:meditations_tracker/common/localization/_init.dart'
    as localization;
import 'package:meditations_tracker/logging/_init.dart' as logging;
import 'package:meditations_tracker/navigation/_init.dart' as navigation;
import 'package:meditations_tracker/service/_init.dart' as services;

// It is better to have it as a `const` because of tree-shaking https://stackoverflow.com/a/55612795/3090951
const _DEBUG = flutter_foundation.kDebugMode;

class Configuration {
  bool isDebug() => _DEBUG;

  bool isRelease() => !_DEBUG;
}

typedef AppAsyncInitializer = Future<bool> Function();

class AppInitializer {
  bool _initializedSync = false;
  bool _initializedAsync = false;

  final Configuration config;

  AppInitializer(this.config);

  Future<bool> initSync(GetIt locator) async {
    if (_initializedSync) return false;

    WidgetsFlutterBinding.ensureInitialized();

    locator.registerSingleton(config);
    locator.registerSingleton(AppStyle());
    locator.registerLazySingleton<AppAsyncInitializer>(
      () => () => initAsync(locator),
    );

    initLocatorSyncContext(locator);

    final logger = locator<Logger>();
    FlutterError.onError = (FlutterErrorDetails details) {
      logger.severe(details.context, details.exception, details.stack);
    };

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    if (config.isRelease()) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    _initializedSync = true;
    return true;
  }

  Future<bool> initAsync(GetIt locator) async {
    if (_initializedAsync) return false;
    //await Firebase.initializeApp();
    final result = await initLocatorAsyncContext(locator);
    _initializedAsync = true;
    return result;
  }

  void initLocatorSyncContext(GetIt locator) {
    logging.initLocator(locator);
    navigation.initLocator(locator);
    localization.initLocator(locator);
    services.initLocator(locator);
  }

  Future<bool> initLocatorAsyncContext(GetIt locator) async {
    return true;
  }
}
