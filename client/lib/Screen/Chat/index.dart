import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutterapp/Screen/Chat/widgets/ChatContent.dart';
import 'package:flutterapp/Screen/Chat/widgets/ChatTool.dart';
import 'package:flutterapp/Util/AppInitializer.dart';
import 'package:flutterapp/Util/DependencyInjection.dart';
import 'package:flutterapp/Util/SocketService.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatelessWidget {
  ChatScreen({Key key,this.sService}) : super(key: key);

  final SocketService sService;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _MyChatPage(key,sService);
  }
}

class _MyChatPage extends StatefulWidget {
  _MyChatPage(Key key,this.sService) : super(key: key);

  final SocketService sService;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<_MyChatPage> {
  TextEditingController _controller;
  List<String> message = [];

  void connectSocket(){
    widget.sService.socket.on("receive", (value) {
      List<String> newMessage = message.toList();
      newMessage.add(value);

      if(mounted){
        setState(() {
          message = newMessage;
        });
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectSocket();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();

  }


  void _handleOnSubmit(String value) {
    List<String> newMessage = message.toList();
    newMessage.add("Client: " + value);

    setState(() {
      message = newMessage;
    });

    widget.sService.socket.emit("send", value);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ChatContent(
            message: message,
          ),
          ChatTool(
            controller: _controller,
            onSubmit: _handleOnSubmit,
          )
        ],
      ),
    );
  }
}
