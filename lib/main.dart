import 'package:coronavirusapp/screens/info/info_screen.dart';
import 'package:coronavirusapp/screens/licenses/licenses_screen.dart';
import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/screens/map/map_screen.dart';
import 'package:coronavirusapp/store/root_reducer.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:coronavirusapp/store/store.dart';
import 'package:coronavirusapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var store = await configureStore();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((x) => runApp(ReduxApp(store: store)));
}

class ReduxApp extends StatelessWidget {
  final Store<AppState> store;

  ReduxApp({this.store});

  @override
  Widget build(BuildContext context) {
    var initialRoute = areTermsAccepted(store.state) ? '/home' : '/info';

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: createTheme(context),
        routes: {
          '/home': (context) => MapScreen(),
          '/info': (context) => ConnectedInfoScreen(),
          '/licenses': (context) => LicensesScreen(),
        },
        initialRoute: initialRoute,
        localizationsDelegates: [
          AppLocalizationsDelegate(context),
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('it'), // Italian
        ],
      ),
    );
  }
}
