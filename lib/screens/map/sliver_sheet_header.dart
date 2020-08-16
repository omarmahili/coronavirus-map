import 'package:coronavirusapp/screens/map/countries_list_header.dart';
import 'package:coronavirusapp/screens/map/countries_search.dart';
import 'package:coronavirusapp/screens/map/draggable_sheet_handle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverSheetHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: <Widget>[
              DraggableSheetHandle(),
              ConnectedCountriesSearch(),
              CountriesListHeader(),
            ],
          ),
          color: Colors.white,
        ),
        Divider(height: 1.0),
      ],
    );
  }

  @override
  double get maxExtent => 116;

  @override
  double get minExtent => 116;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
