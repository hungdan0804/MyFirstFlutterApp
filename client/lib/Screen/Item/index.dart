
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Screen/Item/widgets/MyHeader.dart';
import 'package:flutterapp/Screen/Item/widgets/MyThumbnailItem.dart';
import 'package:flutterapp/Screen/Item/widgets/MyTitleItem.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen({Key key, this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return _MyItemPage(
      data: data,
    );
  }
}

class _MyItemPage extends StatefulWidget {
  _MyItemPage({Key key, this.data}) : super(key: key);

  final String data;

  @override
  _MyItemPageState createState() => _MyItemPageState();
}

class _MyItemPageState extends State<_MyItemPage> {
  String get data => widget.data;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Stack(
          children: <Widget>[
            MyHeader(),
            MyTitleItem(title: data),
            MyThumbnailItem()
          ],
        ));
  }
}