import 'package:coronavirusapp/screens/info/custom_button_bar.dart';
import 'package:coronavirusapp/screens/info/info_content.dart';
import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/store/info/actions.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:coronavirusapp/store/root_reducer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ConnectedInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (context, viewModel) => InfoScreen(
          version: viewModel["version"],
          isInitial: !viewModel["termsAccepted"],
          acceptTerms: viewModel["acceptTerms"],
      ),
      converter: (Store<AppState> store) => {
        "version": getVersion(store.state),
        "termsAccepted": areTermsAccepted(store.state),
        "acceptTerms": () => store.dispatch(acceptTerms()),
      },
    );
  }
}

class InfoScreen extends StatelessWidget {
  final String version;
  final bool isInitial;
  final Function acceptTerms;

  InfoScreen({this.version, this.isInitial, this.acceptTerms});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .translate(["information", "information"])),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: InfoContent(version: version),
            ),
          ),
          Visibility(
            child: CustomButtonBar(
              onAccept: () {
                this.acceptTerms();
                Navigator.of(context).pushReplacementNamed('/home');
              },
              onRefuse: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
            visible: isInitial,
          )
        ],
      ),
    );
  }
}
