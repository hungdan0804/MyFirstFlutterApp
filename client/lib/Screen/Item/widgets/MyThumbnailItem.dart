import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Util/sizes_helper.dart';

class MyThumbnailItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
        alignment: Alignment.topCenter,
        child: new Container(
          width: displayWidth(context) * 0.5,
          height: displayHeight(context) * 0.5,
          alignment: Alignment.topLeft,
          decoration: new BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.contain,
                image: new NetworkImage(
                    "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/gnocchi-1d16725.jpg?quality=90&webp=true&resize=300,272")),
          ),
        ));
  }
}