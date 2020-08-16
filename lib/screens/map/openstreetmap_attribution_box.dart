import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenStreetMapAttributionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 10.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.caption,
          children: <TextSpan>[
            TextSpan(text: '© '),
            TextSpan(
              text: 'OpenStreetMap',
              style: Theme.of(context).textTheme.caption.copyWith(
                color: Colors.blue,
              ),
              recognizer: new TapGestureRecognizer()
                ..onTap = (){
                  launch('https://www.openstreetmap.org/copyright');
                },
            ),
            TextSpan(text: ' contributors'),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0)),
        color: Colors.white54,
      ),
    );
  }
}
