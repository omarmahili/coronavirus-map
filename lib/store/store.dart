import 'package:coronavirusapp/store/root_reducer.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_thunk/redux_thunk.dart';

configureStore() async {
  var persistor = new Persistor(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  var initialState = await persistor.load();

  var store = new Store<AppState>(
    rootReducer,
    middleware: [persistor.createMiddleware(), thunkMiddleware, new LoggingMiddleware.printer()],
    initialState: initialState,
  );

  return store;
}
