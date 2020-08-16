import 'package:coronavirusapp/store/info/model.dart';
import 'package:coronavirusapp/store/model.dart';

enum InfoActions {
  ACCEPT_TERMS,
}

InfoState infoReducer(InfoState state, ReduxAction action) {
  switch (action.type) {
    case InfoActions.ACCEPT_TERMS:
      return state.copyWith(termsAccepted: true);
    default:
      return state;
  }
}

var getVersion = (InfoState state) => state.version;
var areTermsAccepted = (InfoState state) => state.termsAccepted;
