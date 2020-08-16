import 'dart:math';

import 'package:coronavirusapp/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class Utils {
  static sortAndCreateMarkers(List<Country> countries) {
    countries.sort((a, b) => a.stats.cases < b.stats.cases ? 1 : -1);

    var maxRadius = 8.0;
    var minRadius = 4.0;
    var maxCases = countries[0].stats.cases;

    countries.sublist(countries.length - 11).forEach((x) {
      if (x.stats.cases > 0) {
        x.marker = new CircleMarker(
          point: x.position,
          radius: max(minRadius, maxRadius * (x.stats.cases / maxCases)),
          color: Colors.red.withOpacity(0.5),
        );
      }
    });

    maxRadius = 12.0;
    countries.sublist(11, countries.length - 11).forEach((x) {
      if (x.stats.cases > 0) {
        x.marker = new CircleMarker(
          point: x.position,
          radius: max(minRadius, maxRadius * (x.stats.cases / maxCases)),
          color: Colors.red.withOpacity(0.5),
        );
      }
    });

    maxRadius = 20.0;
    countries.sublist(0, 11).forEach((x) {
      if (x.stats.cases > 0) {
        x.marker = new CircleMarker(
          point: x.position,
          radius: max(minRadius, maxRadius * (x.stats.cases / maxCases)),
          color: Colors.red.withOpacity(0.5),
        );
      }
    });

    return countries;
  }

  static String formatNumber(int value) {
    var formattedNumber = "";
    var stringNumber = value.toString();
    for (var i = stringNumber.length - 1; i >= 0; i--) {
      var position = stringNumber.length - i;
      var groupingChar =
          position != 0 && position % 3 == 0 && i != 0 ? " " : "";
      formattedNumber = "$groupingChar${stringNumber[i]}$formattedNumber";
    }

    return formattedNumber;
  }
}
