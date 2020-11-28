import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  final List userList;
  HomeScreen({Key key, @required this.userList}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(userList);
}

class _HomeState extends State<HomeScreen> {
  List userList;
  _HomeState(this.userList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Home Page'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(userList: userList),
    );
  }
}
