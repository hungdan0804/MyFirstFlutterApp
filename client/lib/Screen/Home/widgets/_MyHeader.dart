
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Object/GlobalState.dart';
import 'package:flutterapp/Util/sizes_helper.dart';
import 'package:provider/provider.dart';

class MyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        height: displayHeight(context) * 0.12,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            new Positioned(
              top: -displayHeight(context) * 0.12,
              child: new Container(
                width: displayWidth(context) * 0.7,
                height: displayHeight(context) * 0.23,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Consumer<GlobalState>(
                        builder: (context, mymodel, child) {
                          return Text(
                            mymodel.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Times New Roman',
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          );
                        }),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.elliptical(
                        displayWidth(context) * 0.7,
                        displayHeight(context) * 0.23)),
                    border: Border.all(color: Colors.red, width: 4.0)),
              ),
            )
          ],
        ));
  }
}