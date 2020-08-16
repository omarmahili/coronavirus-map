import 'package:coronavirusapp/models/country.dart';
import 'package:coronavirusapp/models/country_stats.dart';

class CountriesState {
  List<Country> list;
  List<Country> filteredByContinent;
  String searchQuery;
  List<Country> results;
  bool error;
  Country selected;
  CountryStats totalStats;

  CountriesState(
      {this.list,
      this.filteredByContinent,
      this.results,
      this.searchQuery,
      this.error,
      this.selected,
      this.totalStats});

  CountriesState copyWith(
          {list,
          filteredByContinent,
          results,
          searchQuery,
          error,
          selected,
          totalStats}) =>
      CountriesState(
        list: list ?? this.list,
        filteredByContinent: filteredByContinent ?? this.filteredByContinent,
        results: results ?? this.results,
        searchQuery: searchQuery ?? this.searchQuery,
        error: error ?? this.error,
        selected: selected ?? this.selected,
        totalStats: totalStats ?? this.totalStats,
      );

  factory CountriesState.initial() => CountriesState(
        list: null,
        filteredByContinent: null,
        results: null,
        searchQuery: null,
        error: false,
        selected: null,
        totalStats: CountryStats(deaths: 0, cases: 0),
      );
}
