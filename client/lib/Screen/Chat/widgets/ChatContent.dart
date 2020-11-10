import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatContent extends StatelessWidget {
  ChatContent({Key key, this.message}) : super(key: key);
  final List<String> message;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: message.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Center(child: Text(message[index])),
              );
            }),
      ),
    );
  }
}
