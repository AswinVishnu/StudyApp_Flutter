import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Practice_Tests/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class PracticeTestsScreen extends StatefulWidget {
  List userList;
  PracticeTestsScreen({
    Key key,
    @required this.userList,
  }) : super(key: key);
  @override
  _PracticeTestsState createState() => _PracticeTestsState(userList);
}

class _PracticeTestsState extends State<PracticeTestsScreen> {
  List userList;

  _PracticeTestsState(this.userList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Practice Test'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(),
    );
  }
}
