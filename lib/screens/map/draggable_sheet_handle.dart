import 'package:flutter/material.dart';

class DraggableSheetHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.all(Radius.circular(4.0)),
        color: Colors.black12
      ),
    );
  }
}
