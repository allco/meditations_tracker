import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/common/localization/app_localization.dart';

typedef AppLocalizationFactory = AppLocalization Function(Locale locale);

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  final AppLocalizationFactory localizationFactory;

  const AppLocalizationsDelegate(this.localizationFactory);

  factory AppLocalizationsDelegate.create(GetIt locator) {
    return AppLocalizationsDelegate(
      locator(),
    );
  }

  @override
  bool isSupported(Locale locale) {
    final first = getSupportedLocales().firstWhere(
      (supported) => supported.languageCode == locale.languageCode,
      orElse: () => null,
    );
    return first != null;
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final AppLocalization localizations = localizationFactory(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
