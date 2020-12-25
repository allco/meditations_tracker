import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/common/localization/app_localization.dart';
import 'package:meditations_tracker/common/localization/app_localization_delegate.dart';
import 'package:meditations_tracker/common/localization/locale_service.dart';

void initLocator(GetIt locator) {
  locator.registerLazySingleton(() => AppLocalizationsDelegate.create(locator));
  locator.registerLazySingleton(() => getLocalizationsDelegates(locator));
  locator.registerLazySingleton(() => LocaleService.create(locator));

  locator.registerLazySingleton<AppLocalizationFactory>(
    () => (locale) => AppLocalization.create(locator, locale),
  );

  locator.registerLazySingleton<LocaleResolutionCallback>(
    () => createLocaleResolutionCallback(locator),
  );
}
