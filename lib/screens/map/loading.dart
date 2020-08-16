import 'package:coronavirusapp/screens/localization.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool withText;
  final double size;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  Loading({
    this.withText = false,
    this.size = 24,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: this.mainAxisAlignment,
        crossAxisAlignment: this.crossAxisAlignment,
        children: <Widget>[
          Container(
            child: CircularProgressIndicator(),
            width: size,
            height: size,
            margin: EdgeInsets.only(right: withText == true ? 16.0 : 0.0),
          ),
          Visibility(
            child: Text(
                AppLocalizations.of(context).translate(["misc", "loading"])),
            visible: withText ?? false,
          ),
        ],
      ),
      height: 50.0,
    );
  }
}
