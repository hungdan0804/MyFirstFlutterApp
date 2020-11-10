import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Util/sizes_helper.dart';

typedef void _handleOnSubmit(String value);

class ChatTool extends StatelessWidget {
  ChatTool({Key key, this.onSubmit, this.controller}) : super(key: key);

  final TextEditingController controller;
  final _handleOnSubmit onSubmit;

  FocusNode focusNode = new FocusNode();

  void handleOnSubmit(value, context) {
    onSubmit(value);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: displayWidth(context) * 0.7,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onSubmitted: onSubmit,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () =>
                      handleOnSubmit(controller.value.text, context),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
