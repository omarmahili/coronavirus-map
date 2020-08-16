import 'dart:convert';

import 'package:coronavirusapp/api/api.dart';
import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/screens/map/error_message.dart';
import 'package:coronavirusapp/screens/map/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LicensesScreen extends StatefulWidget {
  @override
  _LicensesScreenState createState() => _LicensesScreenState();
}

class _LicensesScreenState extends State<LicensesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .translate(["information", "licenses"])),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FutureBuilder(
              future: API.loadLicenses(context),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) {
                  return ErrorMessage();
                } else if (snapshot.hasData) {
                  return WebView(
                    initialUrl: 'about:blank',
                    onWebViewCreated: (WebViewController controller) {
                      controller.loadUrl(Uri.dataFromString(
                        snapshot.data,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('UTF-8'),
                      ).toString());
                    },
                  );
                }

                return Loading(
                  size: 48.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
