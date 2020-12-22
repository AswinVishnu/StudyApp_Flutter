import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Study_Materials/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';
import 'package:flutter_auth/Models/category.dart';

class StudyMaterialsScreen extends StatefulWidget {
  final List userList;
  final  List categoryList;
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
        title: new Text(userList[7]),
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(
          userList: userList, categoryList: categoryList, isLoading: isLoading),
      bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }
}
