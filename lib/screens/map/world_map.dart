import 'package:coronavirusapp/models/continent.dart';
import 'package:coronavirusapp/models/country.dart';
import 'package:coronavirusapp/store/model.dart';
import 'package:coronavirusapp/store/root_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:latlong/latlong.dart';
import 'package:redux/redux.dart';

class ConnectedWorldMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (context, viewModel) {
        Continent selectedContinent = viewModel["continent"];
        List<CircleMarker> markers = List();
        List<Country> countries = viewModel["countries"];
        if (countries != null) {
          markers = countries
              .where(
                (x) =>
                    (selectedContinent.id == null ||
                        x.continentId == selectedContinent.id) &&
                    x.marker != null,
              )
              .map((x) => x.marker)
              .toList();
        }
        return WorldMap(
          markers: markers,
          selectedContinent: selectedContinent.id,
          selectedCountry: viewModel["selectedCountry"],
          continentCenter: selectedContinent.position,
        );
      },
      converter: (Store<AppState> store) {
        return {
          "continent": getSelectedContinent(store.state),
          "countries": getCountriesResults(store.state),
          "selectedCountry": getSelectedCountry(store.state),
        };
      },
    );
  }
}

class WorldMap extends StatefulWidget {
  final List<CircleMarker> markers;
  final LatLng continentCenter;
  final int selectedContinent;
  final Country selectedCountry;

  WorldMap({
    this.markers,
    this.continentCenter,
    this.selectedContinent,
    this.selectedCountry,
  });

  @override
  _WorldMapState createState() => _WorldMapState();
}

class _WorldMapState extends State<WorldMap> {
  final MapController mapController = MapController();
  final LatLng defaultCenter = LatLng(0, 0);
  final double maxZoom = 4.0;
  final double defaultZoom = 0.5;
  final double continentZoom = 1.5;

  @override
  void initState() {
    super.initState();

    // TODO: remove this bugfix and solve issue
    // fixes map not centered correctly the first time
    mapController.onReady.then((_) {
      Future.delayed(Duration(milliseconds: 100)).then(
        (_) => mapController.move(LatLng(0.0000001, 0.0000001), defaultZoom),
      );
    });
  }

  @override
  void didUpdateWidget(WorldMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedContinent != oldWidget.selectedContinent) {
      mapController.move(
        widget.continentCenter ?? defaultCenter,
        widget.continentCenter != null ? continentZoom : defaultZoom,
      );
    }

    if (widget.selectedCountry != null &&
        (oldWidget.selectedCountry == null ||
            widget.selectedCountry.name != oldWidget.selectedCountry.name)) {
      mapController.move(widget.selectedCountry.position, maxZoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: defaultCenter,
        zoom: defaultZoom,
        minZoom: defaultZoom,
        maxZoom: maxZoom,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        CircleLayerOptions(
          circles: widget.markers,
        )
      ],
    );
  }
}
