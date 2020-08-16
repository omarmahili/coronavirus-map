import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountriesListHeader extends StatelessWidget {
  static const double WIDTH_CASES = 90;
  static const double WIDTH_DEATHS = 70;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          AppLocalizations.of(context).translate(["misc", "country_region"]),
          style: Theme.of(context).textTheme.subtitle.copyWith(
                color: text["medium-emphasis"],
              ),
        ),
        Row(
          children: [
            SizedBox(
              width: WIDTH_CASES,
              child: Text(
                AppLocalizations.of(context).translate(["misc", "cases"]),
                style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: text["medium-emphasis"],
                    ),
              ),
            ),
            SizedBox(
              width: WIDTH_DEATHS,
              child: Text(
                AppLocalizations.of(context).translate(["misc", "deaths"]),
                style: Theme.of(context).textTheme.subtitle.copyWith(
                      color: text["medium-emphasis"],
                    ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
