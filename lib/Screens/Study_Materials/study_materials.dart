import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Study_Materials/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class StudyMaterialsScreen extends StatefulWidget {
  List userList;
  StudyMaterialsScreen({
    Key key,
    @required this.userList,
  }) : super(key: key);
  @override
  _StudyMaterialsState createState() => _StudyMaterialsState(userList);
}

class _StudyMaterialsState extends State<StudyMaterialsScreen> {
  List userList;

  _StudyMaterialsState(this.userList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Study Materials'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(),
    );
  }
}
