import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Util/sizes_helper.dart';

class MyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        height: displayHeight(context) * 0.3,
        child: Stack(
          children: <Widget>[
            new Positioned(
              top: -displayHeight(context) * 0.3,
              left: -displayWidth(context) * 0.15,
              child: new Container(
                width: displayWidth(context) * 1.3,
                height: displayHeight(context) * 0.55,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                        Radius.circular(displayWidth(context))),
                    border: Border.all(color: Colors.red, width: 4.0)),
              ),
            )
          ],
        ));
  }
}