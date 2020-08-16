import 'package:coronavirusapp/store/continents/model.dart';
import 'package:coronavirusapp/store/countries/model.dart';
import 'package:coronavirusapp/store/info/model.dart';

class ReduxAction {
  dynamic type;
  Map<String, dynamic> payload;

  ReduxAction({this.type, this.payload});
}

class AppState {
  final InfoState info;
  final ContinentsState continents;
  final CountriesState countries;

  AppState({
    this.info,
    this.continents,
    this.countries,
  });

  factory AppState.initial() => AppState(
        info: InfoState.initial(),
        continents: ContinentsState.initial(),
        countries: CountriesState.initial(),
      );

  static AppState fromJson(dynamic json) => json != null
      ? AppState(
          info: InfoState.fromJson(json['info']),
          continents: ContinentsState.initial(),
          countries: CountriesState.initial(),
        )
      : AppState.initial();

  dynamic toJson() => {
    "info": info.toJson(),
  };
}
