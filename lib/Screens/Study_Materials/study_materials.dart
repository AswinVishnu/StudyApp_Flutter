import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Study_Materials/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';

class StudyMaterialsScreen extends StatefulWidget {
  List userList;
  List categoryList;
  var isLoading;
  StudyMaterialsScreen({
    Key key,
    @required this.userList,
    @required this.categoryList,
    @required this.isLoading,
  }) : super(key: key);
  @override
  _StudyMaterialsState createState() =>
      _StudyMaterialsState(userList, categoryList, isLoading);
}

class _StudyMaterialsState extends State<StudyMaterialsScreen> {
  List userList;
  List categoryList;
  var isLoading;

  _StudyMaterialsState(this.userList, this.categoryList, this.isLoading);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: new Text('Study Materials'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(
          userList: userList, categoryList: categoryList, isLoading: isLoading),
      bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }
}
