import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket socket;
  String id;

  createSocketConnection() {
    socket = IO.io("http://192.168.1.41:4001", <String, dynamic>{
      'transports': ['websocket'],
    });

    this.socket.on("connect", (_) => print('Connected'));
    this.socket.on("disconnect", (_) => print('Disconnected'));
  }


}