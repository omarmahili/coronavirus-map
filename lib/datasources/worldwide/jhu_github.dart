import 'package:coronavirusapp/datasources/worldwide/base.dart';
import 'package:coronavirusapp/models/country.dart';
import 'package:coronavirusapp/models/country_stats.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class JHUGithubDatasource extends BaseDatasource {
  final String endpoint =
      "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports";
  final DateTime firstUpload = DateTime(2020, 1, 22);

  Future<String> _getCountriesStats() async {
    var today = DateTime.now().toUtc();
    var dayBefore = DateTime(today.year, today.month, today.day - 1);
    var formatter = DateFormat("MM-dd-yyyy");
    var i = 2;

    while (dayBefore.compareTo(firstUpload) >= 0) {
      var url = "$endpoint/${formatter.format(dayBefore)}.csv";

      var response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      }

      dayBefore = DateTime(today.year, today.month, today.day - (i++));
      await Future.delayed(Duration(milliseconds: 200)); // do not overload server
    }

    throw Exception('Data not found');
  }

  _mapToModel(Map stats) {
    if (stats != null) {
      return CountryStats(
        lastUpdate: DateTime.tryParse(stats["Last_Update"]),
        cases: stats["Confirmed"],
        deaths: stats["Deaths"],
        recovered: stats["Recovered"],
      );
    }

    return CountryStats(cases: 0, deaths: 0, recovered: 0);
  }

  // so if columns change order stats can still be built
  List<Map> _csvLinesToMaps(List<List<dynamic>> stats) {
    List<Map> result = [];
    var header = stats[0];
    for (var i = 1; i < stats.length; i++) {
      var element = stats[i];
      var map = {};
      for (var j = 0; j < header.length; j++) {
        map[header[j]] = element[j];
      }

      result.add(map);
    }

    return result;
  }

  List<Map> _groupByCountry(List<Map> stats) {
    List<Map> grouped = [stats[0]];

    for (var i = 1; i < stats.length; i++) {
      var countryStats = stats[i];
      var found = false;

      for (var group in grouped) {
        if (group["Country_Region"] == countryStats["Country_Region"]) {
          found = true;

          var groupDate = DateTime.tryParse(group["Last_Update"]);
          var statsDate = DateTime.tryParse(countryStats["Last_Update"]);

          // keep most recent
          if (statsDate != null &&
              (groupDate == null || groupDate.compareTo(statsDate) < 0)) {
            group["Last_Update"] = countryStats["Last_Update"];
          }

          group["Confirmed"] =
              (group["Confirmed"] ?? 0) + (countryStats["Confirmed"] ?? 0);
          group["Deaths"] =
              (group["Deaths"] ?? 0) + (countryStats["Deaths"] ?? 0);
          group["Recovered"] =
              (group["Recovered"] ?? 0) + (countryStats["Recovered"] ?? 0);

          break;
        }

        found = false;
      }

      if (!found) {
        grouped.add(countryStats);
      }
    }

    return grouped;
  }

  Future<List<Country>> buildCountriesStats(List<Country> countries) async {
    String stringData = await _getCountriesStats();

    var settingsDetector = new FirstOccurrenceSettingsDetector(
        eols: ['\r\n', '\n'],
        textDelimiters: ['"', "'"],
        fieldDelimiters: [',', ';']);
    List<List<dynamic>> rawStats =
        CsvToListConverter(csvSettingsDetector: settingsDetector)
            .convert(stringData);

    List<Map> mappedStats = _csvLinesToMaps(rawStats);
    List<Map> groupedStats = _groupByCountry(mappedStats);

    countries.forEach((x) {
      var countryName = (x.mappedName ?? x.name).toLowerCase();
      Map countryStats = groupedStats.firstWhere(
        (y) => y["Country_Region"].toLowerCase() == countryName,
        orElse: () => null,
      );

      x.stats = _mapToModel(countryStats);
    });

    return countries;
  }
}
