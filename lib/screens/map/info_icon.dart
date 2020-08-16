import 'package:coronavirusapp/theme/theme.dart';
import 'package:flutter/material.dart';

class InfoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        splashColor: Colors.black12,
        onTap: () {
          Navigator.pushNamed(
            context,
            '/info',
          );
        },
        child: Container(
          width: 40,
          height: 40,
          child: Icon(
            Icons.info,
            color: text["high-emphasis"],
          ),
        ),
      ),
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
    );
  }
}
