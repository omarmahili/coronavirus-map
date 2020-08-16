import 'dart:developer';

import 'package:coronavirusapp/api/api.dart';
import 'package:coronavirusapp/models/country.dart';
import 'package:coronavirusapp/store/countries/reducer.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:coronavirusapp/store/root_reducer.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ReduxAction loadCountries(List<Country> list, int continent) => ReduxAction(
    type: CountriesActions.LOAD,
    payload: {"list": list, "continent": continent});

ReduxAction setError() => ReduxAction(type: CountriesActions.ERROR);

ThunkAction<AppState> getCountries(BuildContext context) {
  return (Store<AppState> store) async {
    try {
      var list = await API.getCountries(context);
      var continent = getSelectedContinent(store.state);
      store.dispatch(loadCountries(list, continent.id));
    } catch (e) {
      log(e.toString());
      store.dispatch(setError());
    }
  };
}

ReduxAction searchCountries(String searchQuery) => ReduxAction(
    type: CountriesActions.SEARCH, payload: {"searchQuery": searchQuery});

ReduxAction selectCountry(String countryName) => ReduxAction(
    type: CountriesActions.SELECT, payload: {"countryName": countryName});
