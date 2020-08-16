import 'package:coronavirusapp/store/info/reducer.dart' as infoReducer;
import 'package:coronavirusapp/store/model.dart';
import 'package:coronavirusapp/store/continents/reducer.dart' as continentsReducer;
import 'package:coronavirusapp/store/countries/reducer.dart' as countriesReducer;

AppState rootReducer(AppState state, dynamic action) => AppState(
  info: infoReducer.infoReducer(state.info, action),
  continents: continentsReducer.continentsReucer(state.continents, action),
  countries: countriesReducer.countriesReducer(state.countries, action)
);

// VERSION
var getVersion = (AppState state) => infoReducer.getVersion(state.info);
var areTermsAccepted = (AppState state) => infoReducer.areTermsAccepted(state.info);

// CONTINENTS
var getContinentsList = (AppState state) => continentsReducer.getContinentsList(state.continents);
var getSelectedContinent = (AppState state) => continentsReducer.getSelectedContinent(state.continents);
var getContinentsError = (AppState state) => continentsReducer.getContinentsError(state.continents);

// COUNTRIES
var getCountriesResults = (AppState state) => countriesReducer.getCountriesResults(state.countries);
var getCountriesError = (AppState state) => countriesReducer.getCountriesError(state.countries);
var getSelectedCountry =  (AppState state) => countriesReducer.getSelectedCountry(state.countries);
var getCountriesTotalStats =  (AppState state) => countriesReducer.getCountriesTotalStats(state.countries);
