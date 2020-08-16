import 'package:coronavirusapp/models/country.dart';

abstract class BaseDatasource {
  String endpoint;
  Future<List<Country>> buildCountriesStats(List<Country> countries);
}
