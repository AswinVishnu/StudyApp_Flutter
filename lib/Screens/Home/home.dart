import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/models/notifications.dart';
import 'package:flutter_auth/Screens/Notifications/notification_screen.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  final List userList;
  HomeScreen({Key key, @required this.userList}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(userList);
}

class _HomeState extends State<HomeScreen> {
  List userList;
  List<Notifications> NotificationList = List();
  _HomeState(this.userList);

  int counter=0;


    @override
  Widget build(BuildContext context) {

   getAPI();

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: new Text('Home Page'),
        actions: <Widget>[
          // Using Stack to show Notification Badge
          new Stack(
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen(
                              userList: userList,
                              notificationList: NotificationList)),
                    );
                  }),


              counter != 0
                  ? new Positioned(
                right: 11,
                top: 11,
                child: new Container(
                  padding: EdgeInsets.all(2),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    '$counter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
                  : new Container()
            ],
          ),
        ],
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(userList: userList),
      bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }


  getAPI() async {
    // TODO: implement dispose

    var notResponse = await http.get(
        "https://oxystech-study-app-nodejs.herokuapp.com/admin/notification");
    if (notResponse.statusCode == 200) {
       NotificationList = (json.decode(notResponse.body) as List)
          .map((data) => new Notifications.fromJson(data))
          .toList();

    }

        counter= NotificationList.length;


  }
}
