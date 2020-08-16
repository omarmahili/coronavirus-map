import 'package:coronavirusapp/screens/map/animated_draggable_sheet.dart';
import 'package:coronavirusapp/screens/map/continents_dropdow.dart';
import 'package:coronavirusapp/screens/map/openstreetmap_attribution_box.dart';
import 'package:coronavirusapp/screens/map/world_map.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _sheetMinHeight = 250.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double dropdownContainerHeight = statusBarHeight + 72.0;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: _sheetMinHeight,
            child: ConnectedWorldMap(),
          ),
          Positioned(
            top: 8.0 + statusBarHeight,
            left: 8.0,
            right: 8.0,
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ConnectedContinentsDropdown(),
            ),
          ),
          Positioned(
            child: OpenStreetMapAttributionBox(),
            // minus 6.0 to show box under the top right corner of the sheet
            bottom: _sheetMinHeight - 6.0,
            right: 0,
          ),
          AnimatedDraggableSheet(
            minHeight: _sheetMinHeight,
            maxHeight: height - dropdownContainerHeight,
          ),
        ],
      ),
    );
  }
}
