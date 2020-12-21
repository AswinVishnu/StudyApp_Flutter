import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

import 'package:flutter_auth/Screens/Login/components/background.dart';

import 'package:flutter_auth/models/notifications.dart';

class NotificationScreen extends StatefulWidget {
  final List userList;
  final List notificationList;


  NotificationScreen({
    Key key,
    @required this.userList,
    @required this.notificationList,

  }) : super(key: key);
  @override
  _NotificationState createState() => _NotificationState(userList, notificationList);
}

class _NotificationState extends State<NotificationScreen> {
  List userList;

  List notificationList;

  _NotificationState(this.userList, this.notificationList);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: new Text('Notifications'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Background(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: notificationList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return InkWell(
                            onTap: () {}, child: ListItem(notificationList[index],context));
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget ListItem(Notifications listItem, BuildContext context) {
  return ExpansionTile(
    title: Text(
      listItem.title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    ),
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                listItem.description,
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(color: Colors.red),
              )),
        ],
      ),
    ],
  );
}
