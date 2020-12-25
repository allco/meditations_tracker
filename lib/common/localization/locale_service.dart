import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meditations_tracker/service/UserService.dart';

class LocaleService {
  LocaleService(this.userService);

  factory LocaleService.create(GetIt locator) => LocaleService(locator());

  final UserService userService;
  Locale _locale;

  String getLanguageTag() {
    assert(_locale != null);
    return _locale.toLanguageTag();
  }

  String getLanguageCode() {
    assert(_locale != null);
    return _locale.languageCode;
  }

  void resetLocale(Locale locale) {
    assert(locale != null);
    if (_locale == locale) return;
    if (_locale != null) userService.logout();
    _locale = locale;
  }
}
