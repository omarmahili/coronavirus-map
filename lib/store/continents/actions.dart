import 'dart:developer';

import 'package:coronavirusapp/api/api.dart';
import 'package:coronavirusapp/store/continents/reducer.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:coronavirusapp/models/continent.dart';

ReduxAction loadContinents(List<Continent> list) =>
    ReduxAction(type: ContinentsActions.LOAD, payload: {"list": list});

ReduxAction setError() =>
    ReduxAction(type: ContinentsActions.ERROR);

ThunkAction<AppState> getContinents(BuildContext context) {
  return (Store<AppState> store) async {
    try {
      var list = await API.getContinents(context);
      store.dispatch(loadContinents(list));
    } catch (e, s) {
      log(s.toString());
      store.dispatch(setError());
    }
  };
}

ReduxAction selectContinent(int continentId) => ReduxAction(
    type: ContinentsActions.SELECT, payload: {"continentId": continentId});
