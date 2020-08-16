import 'package:coronavirusapp/screens/localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoContent extends StatelessWidget {
  final String version;

  InfoContent({@required this.version});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.body1,
          children: <TextSpan>[
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate(["information", "app_license"]),
              style: Theme.of(context).textTheme.body2,
            ),
            TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.blue),
              text: AppLocalizations.of(context)
                      .translate(["information", "license_link"]),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  launch(
                      'https://creativecommons.org/licenses/by-nc-sa/4.0');
                },
            ),
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate(["information", "at_this"]),
              style: Theme.of(context).textTheme.body2,
            ),
            TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.blue),
              text: AppLocalizations.of(context)
                      .translate(["information", "repository"]),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  launch(
                      'https://github.com/omarmahili/coronavirus-map');
                },
            ),
            TextSpan(
              text: "\n\n${AppLocalizations.of(context).translate([
                "misc",
                "version"
              ])}: $version",
              style: Theme.of(context).textTheme.body2,
            ),
            TextSpan(
              style: Theme.of(context).textTheme.title,
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "terms_of_use"]) +
                  "\n\n",
            ),
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate(["information", "terms_of_use_body"]),
            ),
            TextSpan(
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "software_as_is"]),
            ),
            TextSpan(
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "datasource"]) +
                  "\n\n",
              style: Theme.of(context).textTheme.title,
            ),
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate(["information", "datasource_body"]),
            ),
            TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.blue),
              text: AppLocalizations.of(context)
                  .translate(["information", "this_page"]),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  launch('https://github.com/CSSEGISandData/COVID-19');
                },
            ),
            TextSpan(
              text: AppLocalizations.of(context)
                  .translate(["information", "datasource_body2"]),
            ),
            TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.blue),
              text: AppLocalizations.of(context)
                  .translate(["information", "link"]),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  launch("https://github.com/omarmahili/coronavirus-map/issues");
                },
            ),
            TextSpan(
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "no_warranty_datasource"]),
            ),
            TextSpan(
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "privacy_policy"]),
              style: Theme.of(context).textTheme.title,
            ),
            TextSpan(
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "privacy_policy_body"]),
            ),
            TextSpan(
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "third_party_services"]),
              style: Theme.of(context).textTheme.title,
            ),
            TextSpan(
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "github_raw_data"]),
            ),
            TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(color: Colors.blue),
              text: "\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "github_privacy_statement"]),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  launch(
                      'https://help.github.com/en/github/site-policy/github-privacy-statement#github-privacy-statement');
                },
            ),
            TextSpan(
              text: "\n\n" +
                  AppLocalizations.of(context)
                      .translate(["information", "licenses"]),
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.blue,
                  ),
              recognizer: new TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/licenses');
                },
            )
          ],
        ),
      ),
    );
  }
}
