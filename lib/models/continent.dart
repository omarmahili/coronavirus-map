import 'package:latlong/latlong.dart';

class Continent {
  int id;
  String name;
  LatLng position;

  Continent({this.id, this.name, this.position});

  factory Continent.fromMap(Map<String, dynamic> map) => Continent(
        id: map["id"],
        name: map["name"],
        position: LatLng(map["lat"].toDouble(), map["lon"].toDouble()),
      );
}
