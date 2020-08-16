import 'dart:convert';
import 'dart:developer';

import 'package:coronavirusapp/api/utils.dart';
import 'package:coronavirusapp/datasources/worldwide/datasources.dart';
import 'package:coronavirusapp/models/continent.dart';
import 'package:coronavirusapp/models/country.dart';
import 'package:coronavirusapp/screens/localization.dart';
import 'package:flutter/material.dart';

class API {
  static Future<List<Continent>> getContinents(BuildContext context) {
    return DefaultAssetBundle.of(context)
        .loadString("assets/data/continents.json")
        .then((x) => json.decode(x))
        .then((x) => x.map<Continent>((y) => Continent.fromMap(y)).toList());
  }

  static Future<List<Country>> getCountries(BuildContext context) async {
    List<Country> countries = await DefaultAssetBundle.of(context)
        .loadString("assets/data/countries/countries.json")
        .then((x) => json.decode(x))
        .then((x) => x.map<Country>((y) => Country.fromMap(y)).toList());

    Map<String, dynamic> countriesMapping = await _getCountryMappings(context);
    Map<String, dynamic> countriesTranslations = await _getCountryTranslations(context);

    countries = countries.map((x) {
      var key = x.id.toString();
      if (countriesMapping.containsKey(key)) {
        x.mappedName = countriesMapping[key];
      }

      if (countriesTranslations.containsKey(x.name)) {
        x.translatedName = countriesTranslations[x.name];
      } else {
        log("Error retrieving ${x.name} translation.");
      }

      return x;
    }).toList();

    for (var datasource in Datasources.list) {
      try {
        List<Country> builtCountries = await datasource.buildCountriesStats(countries);
        builtCountries = Utils.sortAndCreateMarkers(builtCountries);

        return builtCountries;
      } catch (e) {
        log("Datasource failed retrieving data: ${e.toString()}.");
        continue;
      }
    }

    throw Exception("Necessary data couldn't be built or retrieved.");
  }

  static Future _getCountryMappings(BuildContext context) {
    return DefaultAssetBundle.of(context)
      .loadString('assets/data/countries_mapping.json')
      .then((x) => json.decode(x));
  }

  static Future _getCountryTranslations(BuildContext context) {
    var currentLanguage = AppLocalizations.of(context).locale.languageCode;
    return DefaultAssetBundle.of(context)
      .loadString('assets/i18n/countries/$currentLanguage.json')
      .then((x) => json.decode(x));
  }

  static Future<Map<String, dynamic>> loadTranslation(BuildContext context, String locale) {
    return DefaultAssetBundle.of(context).loadString("assets/i18n/$locale.json").then((x) => json.decode(x));
  }

  static Future<String> loadLicenses(context) {
    return DefaultAssetBundle.of(context).loadString("assets/licenses/licenses.html");
  }
}
