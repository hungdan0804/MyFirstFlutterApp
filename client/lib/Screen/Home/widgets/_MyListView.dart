import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Object/Recipes.dart';
import 'package:flutterapp/Util/sizes_helper.dart';


typedef void _handleOnTab(value);


class MyListView extends StatelessWidget {
  const MyListView({Key key, this.data, this.onTabbed}) : super(key: key);

  final Future<Recipes> data;
  final _handleOnTab onTabbed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 25, top: 30),
          alignment: Alignment.centerLeft,
          child: Text(
            "Recommend",
            style: TextStyle(
                fontSize: 26,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: displayHeight(context) * 0.6,
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<Recipes>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.payload.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          onTabbed(snapshot.data.payload.elementAt(index));
                        },
                        child: Container(
                          width: displayWidth(context) * 0.6,
                          margin: EdgeInsets.all(10),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: new Color(0xffff1212).withOpacity(0.7),
                          ),
                          child: Column(
                            children: [
                              new Container(
                                width: displayWidth(context) * 0.4,
                                height: displayHeight(context) * 0.32,
                                decoration: new BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.contain,
                                      image: new NetworkImage(
                                          "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/gnocchi-1d16725.jpg?quality=90&webp=true&resize=300,272")),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(1),
                                  child: Text(
                                      snapshot.data.payload.elementAt(index),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white))),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 20),
                                  child: Text(
                                      "Upgrade cheesy tomato pasta with gnocchi, chorizo and mozzarella for a comforting bake that makes an excellent midweek meal",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                          Colors.white.withOpacity(0.5))))
                            ],
                          ),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                );
              } else if (snapshot.hasError) {
                print(snapshot);
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ],
    ));
  }
}
