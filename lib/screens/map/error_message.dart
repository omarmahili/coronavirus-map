import 'package:coronavirusapp/screens/localization.dart';
import 'package:coronavirusapp/theme/theme.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final bool isDense;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  ErrorMessage({
    this.isDense = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    var errorText = isDense
        ? AppLocalizations.of(context).translate(["misc", "error"])
        : AppLocalizations.of(context).translate(["misc", "error_extended"]);

    var padding =
        isDense ? EdgeInsets.only(right: 8.0) : EdgeInsets.only(bottom: 8.0);

    var content = [
      Padding(
        child: Icon(
          Icons.error_outline,
          color: text["medium-emphasis"],
        ),
        padding: padding,
      ),
      SizedBox(
        width: 200,
        child: Text(
          errorText,
          textAlign: isDense ? TextAlign.start : TextAlign.center,
          style: Theme.of(context).textTheme.body1.copyWith(
                color: text["medium-emphasis"],
              ),
        ),
      ),
    ];

    if (isDense) {
      return Row(
        children: content,
        mainAxisAlignment: this.mainAxisAlignment,
        crossAxisAlignment: this.crossAxisAlignment,
      );
    }

    return Column(
      children: content,
      mainAxisAlignment: this.mainAxisAlignment,
      crossAxisAlignment: this.crossAxisAlignment,
    );
  }
}
