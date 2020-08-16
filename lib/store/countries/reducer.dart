import 'package:coronavirusapp/models/country.dart';
import 'package:coronavirusapp/models/country_stats.dart';
import 'package:coronavirusapp/store/continents/reducer.dart';
import 'package:coronavirusapp/store/countries/model.dart';
import 'package:coronavirusapp/store/model.dart';

enum CountriesActions {
  LOAD,
  SEARCH,
  ERROR,
  SELECT,
}

CountryStats createTotalStats(List<Country> countries) {
  int totalCases = 0;
  int totalDeaths = 0;

  countries.forEach((country) {
    totalCases += country.stats.cases;
    totalDeaths += country.stats.deaths;
  });

  return CountryStats(deaths: totalDeaths, cases: totalCases);
}

List<Country> filterBySearchQuery(List<Country> list, String searchQuery) {
  if (searchQuery != "" && searchQuery != null) {
    return list
        .where((x) =>
            x.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            (x.translatedName != null &&
                x.translatedName.toLowerCase().contains(searchQuery.toLowerCase())))
        .toList();
  }

  return list;
}

List<Country> filterByContinent(List<Country> list, int continentId) {
  return continentId == null // All
      ? list
      : list.where((x) => x.continentId == continentId).toList();
}

CountriesState countriesReducer(CountriesState state, ReduxAction action) {
  switch (action.type) {
    case CountriesActions.LOAD:
      var list = action.payload["list"];
      // if user selects continent before loading of countries ends
      var filteredByContinent =
          filterByContinent(list, action.payload["continent"]);

      // search does not need to be handled since it is hidden till loading is complete
      return state.copyWith(
        list: list,
        filteredByContinent: filteredByContinent,
        results: filteredByContinent,
        totalStats: createTotalStats(filteredByContinent),
      );
    case CountriesActions.SEARCH:
      var searchQuery = action.payload["searchQuery"];

      return state.copyWith(
        results: filterBySearchQuery(state.filteredByContinent, searchQuery),
        searchQuery: searchQuery,
      );
    case CountriesActions.SELECT:
      var country = state.list.firstWhere(
        (x) => x.name == action.payload["countryName"],
        orElse: () => null,
      );
      return state.copyWith(selected: country);
    case CountriesActions.ERROR:
      return state.copyWith(error: true);
  }

  switch (action.type) {
    case ContinentsActions.SELECT:
      if (state.list != null) {
        var filteredByContinent =
            filterByContinent(state.list, action.payload["continentId"]);

        return state.copyWith(
          filteredByContinent: filteredByContinent,
          results: filterBySearchQuery(filteredByContinent, state.searchQuery),
          totalStats: createTotalStats(filteredByContinent),
        );
      }
      return state;
    default:
      return state;
  }
}

var getCountriesResults = (CountriesState state) => state.results;
var getCountriesError = (CountriesState state) => state.error;
var getSelectedCountry = (CountriesState state) => state.selected;
var getCountriesTotalStats = (CountriesState state) => state.totalStats;
