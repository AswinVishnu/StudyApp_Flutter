import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Current_Affairs/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class CurrentAffairsScreen extends StatefulWidget {
  final List userList;
  CurrentAffairsScreen({
    Key key,
    @required this.userList,
  }) : super(key: key);
  @override
  _CurrentAffairsState createState() => _CurrentAffairsState(userList);
}

class _CurrentAffairsState extends State<CurrentAffairsScreen> {
  List userList;

  _CurrentAffairsState(this.userList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Current Affairs'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(),
    );
  }
}
