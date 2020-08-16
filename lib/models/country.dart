import 'package:coronavirusapp/models/country_stats.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Country {
  int id;
  String name;
  String mappedName;
  String translatedName;
  int continentId;
  CountryStats stats;
  CircleMarker marker;
  LatLng position;

  Country({
    this.id,
    this.name,
    this.mappedName,
    this.continentId,
    this.position,
    this.marker,
    this.stats,
  });

  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      id: map["id"],
      name: map["name"],
      continentId: map["continentId"],
      position: LatLng(map["lat"], map["lon"]),
    );
  }
}
