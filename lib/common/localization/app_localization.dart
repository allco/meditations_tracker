import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:meditations_tracker/common/localization/app_localization_delegate.dart';
import 'package:meditations_tracker/common/localization/locale_service.dart';

class AppLocalization {
  final Locale locale;
  final Logger logger;

  AppLocalization(this.logger, this.locale);

  factory AppLocalization.create(GetIt locator, Locale locale) {
    return AppLocalization(locator(), locale);
  }

  // TODO(any): Introduce and return here TranslationService
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    try {
      // Load the language JSON file from the "lang" folder
      final String jsonString = await rootBundle
          .loadString('res/localizations/${locale.languageCode}.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    } catch (err) {
      logger.severe('Failed to load locale: $locale');
      rethrow;
    }

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    assert(key != null, 'Translation key is `null`');
    final localizedString = _localizedStrings[key];
    assert(localizedString != null, 'Not found translation for key: $key');
    return localizedString ?? '';
  }

  String call(String key) => translate(key);

  String plural(num count, {@required String keyOne, @required String keyFew}) {
    return translate(count == 1 ? keyOne : keyFew);
  }
}

List<Locale> getSupportedLocales() {
  return const [
    Locale('en'),
    Locale('ru'),
  ];
}

List<LocalizationsDelegate> getLocalizationsDelegates(GetIt locator) {
  return [
    locator<AppLocalizationsDelegate>(),
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}

LocaleResolutionCallback createLocaleResolutionCallback(GetIt locator) =>
    _createLocaleResolutionCallback(locator<LocaleService>().resetLocale);

LocaleResolutionCallback _createLocaleResolutionCallback(
    [Function(Locale) localeChangedCallback]) {
  return (locale, supportedLocales) {
    Locale resultLocale;
    // Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale?.languageCode == locale?.languageCode) {
        resultLocale = supportedLocale;
        break;
      }
    }

    // If the locale of the device is not supported, use the first one
    // from the list (English, in this case).
    resultLocale ??= supportedLocales.first;
    // Notify the app that locale is changed.
    localeChangedCallback?.call(resultLocale);
    return resultLocale;
  };
}
