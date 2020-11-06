import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Object/GlobalState.dart';
import 'package:flutterapp/Object/Recipes.dart';
import 'package:flutterapp/Screen/Item/index.dart';
import 'file:///C:/Users/ADMIN/Desktop/Working_Tesse/flutter_app/lib/Util/sizes_helper.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutterapp/Screen/Home/widgets/_MyHeader.dart' as MyHeader;
import 'package:flutterapp/Screen/Home/widgets/_MyListView.dart' as MyListView;

Future<Recipes> fetchRecipes() async {
  final response = await http.get('http://192.168.1.16:4000/Recipes/GetAll');

  if (response.statusCode == 200) {
    return Recipes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class PushNotificationMessage {
  final String title;
  final String body;
  PushNotificationMessage({
    @required this.title,
    @required this.body,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Recipes> recipes;
  int _selectedIndex = 0;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  void _handleOnTab(value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ItemScreen(
                  data: value,
                )));
  }

  void _onItemTaped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions(data) {
    return (<Widget>[
      Column(
        children: <Widget>[
          MyHeader.MyHeader(),
          MyListView.MyListView(
            data: data,
            onTabbed: (value) => _handleOnTab(value),
          )
        ],
      ),
      ItemScreen(),
      Container(color: Colors.amber)
    ]);
  }



  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: ListTile(
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );


      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(
              sound: true, badge: true, alert: true, provisional: true));
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }

  @override
  void initState() {
    super.initState();
    recipes = fetchRecipes();
    init();
  }



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
        body: Align(child: _widgetOptions(recipes).elementAt(_selectedIndex)),
        bottomNavigationBar: new Container(
            height: displayHeight(context) * 0.13,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
              child: BottomNavigationBar(
                backgroundColor: Colors.red,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                selectedFontSize: 18,
                unselectedFontSize: 16,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: "Profile",
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap: _onItemTaped,
              ),
            )));
  }
}
