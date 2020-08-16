import 'package:coronavirusapp/models/continent.dart';

class ContinentsState {
  List<Continent> list;
  Continent selected;
  bool error;

  ContinentsState({ this.list, this.selected, this.error });

  ContinentsState copyWith({ List<Continent> list, Continent selected, bool error }) => ContinentsState(
    list: list ?? this.list,
    selected: selected ?? this.selected,
    error: error ?? this.error,
  );

  factory ContinentsState.initial() => ContinentsState(list: null, selected: Continent(), error: false);
}
