import 'package:coronavirusapp/api/utils.dart';
import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/screens/map/countries_list_header.dart';
import 'package:coronavirusapp/store/root_reducer.dart';
import 'package:coronavirusapp/screens/map/countries_list_footer.dart';
import 'package:coronavirusapp/screens/map/error_message.dart';
import 'package:coronavirusapp/screens/map/loading.dart';
import 'package:coronavirusapp/models/country.dart';
import 'package:coronavirusapp/screens/map/sliver_sheet_header.dart';
import 'package:coronavirusapp/store/countries/actions.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ConnectedCountriesList extends StatelessWidget {
  final ScrollController controller;
  final Function closeSheet;

  ConnectedCountriesList({this.controller, this.closeSheet});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(builder: (context, viewModel) {
      return CountriesList(
        countries: viewModel["list"],
        load: viewModel["load"],
        error: viewModel["error"],
        controller: controller,
        onItemTap: (countryName) {
          viewModel["select"](countryName);
          closeSheet();
        },
      );
    }, converter: (Store<AppState> store) {
      return {
        "load": (context) => getCountries(context)(store),
        "select": (countryName) => store.dispatch(selectCountry(countryName)),
        "list": getCountriesResults(store.state),
        "error": getCountriesError(store.state),
      };
    });
  }
}

class CountriesList extends StatefulWidget {
  final Function load;
  final List<Country> countries;
  final ScrollController controller;
  final bool error;
  final Function onItemTap;

  CountriesList({
    @required this.load,
    @required this.countries,
    @required this.error,
    @required this.onItemTap,
    this.controller,
  });

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  @override
  void initState() {
    super.initState();

    widget.load(context);
  }

  _updatedString(DateTime dt) {
    DateTime now = DateTime.now().toUtc();
    Duration difference = now.difference(dt);

    var updatedTranslation =
        AppLocalizations.of(context).translate(["misc", "updated"]);
    var yearsTranslation =
        AppLocalizations.of(context).translate(["misc", "years"]);
    var yearTranslation =
        AppLocalizations.of(context).translate(["misc", "year"]);
    var monthsTranslation =
        AppLocalizations.of(context).translate(["misc", "months"]);
    var monthTranslation =
        AppLocalizations.of(context).translate(["misc", "month"]);
    var daysTranslation =
        AppLocalizations.of(context).translate(["misc", "days"]);
    var dayTranslation =
        AppLocalizations.of(context).translate(["misc", "day"]);
    var weeksTranslation =
        AppLocalizations.of(context).translate(["misc", "weeks"]);
    var weekTranslation =
        AppLocalizations.of(context).translate(["misc", "week"]);
    var hoursTranslation =
        AppLocalizations.of(context).translate(["misc", "hours"]);
    var hourTranslation =
        AppLocalizations.of(context).translate(["misc", "hour"]);
    var minutesTranslation =
        AppLocalizations.of(context).translate(["misc", "minutes"]);
    var minuteTranslation =
        AppLocalizations.of(context).translate(["misc", "minute"]);
    var agoTranslation =
        AppLocalizations.of(context).translate(["misc", "ago"]);
    var nowTranslation =
        AppLocalizations.of(context).translate(["misc", "just_now"]);

    if (difference.inDays >= 365) {
      var years = difference.inDays / ~365;
      return years == 1
          ? "$updatedTranslation $years $yearTranslation $agoTranslation"
          : "$updatedTranslation $years $yearsTranslation $agoTranslation";
    }

    if (difference.inDays >= 30) {
      var months = difference.inDays / ~30;
      return months == 1
          ? "$updatedTranslation $months $monthTranslation $agoTranslation"
          : "$updatedTranslation $months $monthsTranslation $agoTranslation";
    }

    if (difference.inDays > 0) {
      var days = difference.inDays;
      if (days == 1) {
        return "$updatedTranslation $days $dayTranslation $agoTranslation";
      } else if (days < 7) {
        return "$updatedTranslation $days $daysTranslation $agoTranslation";
      } else if (days >= 7) {
        var weeks = days ~/ 7;
        if (weeks == 1) {
          return "$updatedTranslation $weeks $weekTranslation $agoTranslation";
        }

        return "$updatedTranslation $weeks $weeksTranslation $agoTranslation";
      }
    }

    if (difference.inHours > 0) {
      var hours = difference.inHours;
      return hours == 1
          ? "$updatedTranslation $hours $hourTranslation $agoTranslation"
          : "$updatedTranslation $hours $hoursTranslation $agoTranslation";
    }

    if (difference.inMinutes > 0) {
      var minutes = difference.inMinutes;
      return minutes == 1
          ? "$updatedTranslation $minutes $minuteTranslation $agoTranslation"
          : "$updatedTranslation $minutes $minutesTranslation $agoTranslation";
    }

    return "$updatedTranslation $nowTranslation";
  }

  Widget buildSliverListContent() {
    if (widget.countries.length > 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Country country = widget.countries[index];

            return Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black12,
                onTap: () => widget.onItemTap(country.name),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  title: Text(country.translatedName ?? country.name),
                  subtitle: country.stats.lastUpdate != null
                      ? Text(_updatedString(country.stats.lastUpdate))
                      : null,
                  trailing: SizedBox(
                    width: CountriesListHeader.WIDTH_CASES + CountriesListHeader.WIDTH_DEATHS,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: CountriesListHeader.WIDTH_CASES,
                          child: Text(Utils.formatNumber(country.stats.cases)),
                        ),
                        SizedBox(
                          width: CountriesListHeader.WIDTH_DEATHS,
                          child: Text(Utils.formatNumber(country.stats.deaths)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: widget.countries != null ? widget.countries.length : 0,
        ),
      );
    }

    return SliverFillRemaining(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context).translate(["misc", "no_results"]),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.error) {
      return ErrorMessage();
    }

    if (widget.countries == null) {
      return Loading(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      );
    }

    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 33.0), // footer height
          child: CustomScrollView(
            controller: widget.controller,
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverSheetHeaderDelegate(),
              ),
              buildSliverListContent(),
            ],
          ),
        ),
        Positioned(
          child: ConnectedCountriesListFooter(),
          bottom: 0,
          left: 0,
          right: 0,
        ),
      ],
    );
  }
}
