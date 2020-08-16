import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/screens/map/info_icon.dart';
import 'package:coronavirusapp/store/root_reducer.dart';
import 'package:coronavirusapp/screens/map/error_message.dart';
import 'package:coronavirusapp/screens/map/loading.dart';
import 'package:coronavirusapp/models/continent.dart';
import 'package:coronavirusapp/store/continents/actions.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ConnectedContinentsDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        builder: (context, viewModel) => ContinentsDropdown(
              load: viewModel["load"],
              list: viewModel["list"],
              onChanged: viewModel["onChanged"],
              value: viewModel["value"].id,
              error: viewModel["error"],
            ),
        converter: (Store<AppState> store) => {
              "load": () => getContinents(context)(store),
              "onChanged": (value) => store.dispatch(selectContinent(value)),
              "list": getContinentsList(store.state),
              "value": getSelectedContinent(store.state),
              "error": getContinentsError(store.state),
            });
  }
}

class ContinentsDropdown extends StatefulWidget {
  final Function load;
  final Function onChanged;
  final int value;
  final List<Continent> list;
  final bool error;

  ContinentsDropdown({
    @required this.load,
    @required this.list,
    @required this.onChanged,
    @required this.value,
    @required this.error,
  });

  @override
  _ContinentsDropdownState createState() => _ContinentsDropdownState();
}

class _ContinentsDropdownState extends State<ContinentsDropdown> {
  var _horizontalPadding = 16.0;

  @override
  void initState() {
    super.initState();

    widget.load();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.error) {
      return SizedBox(
        height: 50.0,
        child: Padding(
          // right padding is only 4.0 because icon is already surrounded by padding
          padding: EdgeInsets.only(left: _horizontalPadding, right: 4.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ErrorMessage(
                  isDense: true,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              InfoIcon(),
            ],
          ),
        ),
      );
    }

    if (widget.list == null) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Loading(withText: true),
      );
    }

    var items = [
      DropdownMenuItem<int>(
          value: null,
          child: Text(AppLocalizations.of(context)
              .translate(["misc", "all_continents"]))),
    ];

    widget.list.forEach((x) {
      items.add(DropdownMenuItem<int>(
          value: x.id,
          child: Text(
              AppLocalizations.of(context).translate(["continents", x.name]))));
    });

    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: DropdownButton<int>(
          value: widget.value,
          hint: Text(AppLocalizations.of(context)
              .translate(["misc", "all_continents"])),
          itemHeight: 50.0,
          isExpanded: true,
          underline: Container(height: 0),
          icon: Row(
            children: <Widget>[
              Icon(Icons.arrow_drop_down),
              InfoIcon(),
            ],
          ),
          onChanged: (value) {
            widget.onChanged(value);

            // reset focus to avoid going back to country search
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          items: items,
        ),
      ),
    );
  }
}
