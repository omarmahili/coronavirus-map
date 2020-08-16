import 'package:coronavirusapp/screens/localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtonBar extends StatelessWidget {
  final Function onAccept;
  final Function onRefuse;

  CustomButtonBar({ @required this.onAccept, @required this.onRefuse });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 16.0),
              child: MaterialButton(
                color: Colors.white,
                textColor: Colors.black,
                onPressed: onRefuse,
                child: Text(AppLocalizations.of(context).translate(["information", "refuse"])),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
              child: MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: onAccept,
                child: Text(AppLocalizations.of(context).translate(["information", "accept"])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
