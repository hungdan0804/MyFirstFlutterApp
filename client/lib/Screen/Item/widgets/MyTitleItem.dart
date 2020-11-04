import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Util/sizes_helper.dart';


class MyTitleItem extends StatelessWidget {
  MyTitleItem({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child:Container(
          width: displayWidth(context)*0.7,
          child:Text(
            title,
            style: TextStyle(
                fontSize: 20, fontFamily: 'Times New Roman', color: Colors.white,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        )
    );
  }
}