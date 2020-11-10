import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutterapp/Object/GlobalState.dart';
import 'Screen/Home/index.dart';
import 'package:provider/provider.dart';

import 'Util/AppInitializer.dart';
import 'Util/DependencyInjection.dart';
import 'Util/SocketService.dart';


void main() async {
  DependencyInjection().initialise(Injector.getInjector());
  Injector injector = Injector.getInjector();
  await AppInitializer().initialise(injector);

  SocketService socketService;

  socketService = injector.get<SocketService>();
  socketService.createSocketConnection();

  runApp(MyApp(socket: socketService,));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  MyApp({Key key,this.socket}):super(key: key);

  final SocketService socket;

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalState>(
        create: (context) => GlobalState(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page',socket: socket,),
        ));
  }
}
