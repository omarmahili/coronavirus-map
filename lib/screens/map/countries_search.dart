import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/store/countries/actions.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ConnectedCountriesSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(builder: (context, onChanged) {
      return CountriesSearch(onChanged: onChanged);
    }, converter: (Store<AppState> store) {
      return (searchQuery) => store.dispatch(searchCountries(searchQuery));
    });
  }
}

class CountriesSearch extends StatelessWidget {
  final Function onChanged;

  CountriesSearch({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 12.0),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
          labelText: AppLocalizations.of(context).translate(["misc", "search_country"]),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
