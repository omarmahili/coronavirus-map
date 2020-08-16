import 'dart:async';

import 'package:coronavirusapp/api/api.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, dynamic> _translations;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String translate(List<String> keys) {
    if (keys.length == 0) {
      throw Exception("List of keys cannot be empty.");
    }

    if (_translations != null) {
      var value = _translations[keys.first];
      keys.skip(1).forEach((x) {
        if (value[x] == null) {
          throw Exception("Translation not found for: ${keys.join(", ")}.");
        }

        value = value[x];
      });

      return value;
    }

    throw Exception("Translations are not available.");
  }

  Future load(BuildContext context) async {
    _translations = await API.loadTranslation(context, locale.languageCode);
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  final BuildContext context;
  final List<String> supportedLocales = ['en', 'it'];

  AppLocalizationsDelegate(this.context);

  @override
  bool isSupported(Locale locale) => true; // fake that it supports all given locale

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // if locale is actually not supported fallback to english
    var currentLocale = supportedLocales.contains(locale.languageCode) ? locale : Locale('en');
    var appLocalization = AppLocalizations(currentLocale);
    await appLocalization.load(context);

    return appLocalization;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
