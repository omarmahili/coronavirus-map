import 'package:coronavirusapp/api/utils.dart';
import 'package:coronavirusapp/models/country_stats.dart';
import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/screens/map/countries_list_header.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:coronavirusapp/store/root_reducer.dart';
import 'package:coronavirusapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ConnectedCountriesListFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (context, CountryStats totalStats) {
        return CountriesListFooter(
          totalCases: totalStats.cases,
          totalDeaths: totalStats.deaths,
        );
      },
      converter: (Store<AppState> store) => getCountriesTotalStats(store.state),
    );
  }
}

class CountriesListFooter extends StatelessWidget {
  final int totalCases;
  final int totalDeaths;

  CountriesListFooter({this.totalCases, this.totalDeaths});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: 1),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          color: Colors.white,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              AppLocalizations.of(context).translate(["misc", "total"]),
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: text["medium-emphasis"],
                  ),
            ),
            Row(
              children: [
                SizedBox(
                  width: CountriesListHeader.WIDTH_CASES,
                  child: Text(
                    Utils.formatNumber(totalCases),
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          color: text["medium-emphasis"],
                        ),
                  ),
                ),
                SizedBox(
                  width: CountriesListHeader.WIDTH_DEATHS,
                  child: Text(
                    Utils.formatNumber(totalDeaths),
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          color: text["medium-emphasis"],
                        ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
}
