import 'package:coronavirusapp/models/continent.dart';
import 'package:coronavirusapp/store/continents/model.dart';
import 'package:coronavirusapp/store/model.dart';

enum ContinentsActions {
  LOAD,
  SELECT,
  ERROR,
}

ContinentsState continentsReucer(ContinentsState state, ReduxAction action) {
  switch (action.type) {
    case ContinentsActions.LOAD:
      return state.copyWith(list: action.payload["list"]);
    case ContinentsActions.SELECT:
      var selected = state.list.firstWhere((x) => x.id == action.payload["continentId"], orElse: () => Continent());
      return state.copyWith(selected: selected);
    case ContinentsActions.ERROR:
      return state.copyWith(error: true);
    default:
      return state;
  }
}

var getContinentsList = (ContinentsState state) => state.list;
var getSelectedContinent = (ContinentsState state) => state.selected;
var getContinentsError = (ContinentsState state) => state.error;
