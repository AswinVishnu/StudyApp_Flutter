import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Study_Materials/study_materials.dart';
import 'package:flutter_auth/Screens/Question_Bank/question_bank.dart';
import 'package:flutter_auth/Screens/Current_Affairs/current_affairs.dart';
import 'package:flutter_auth/Screens/Practice_Tests/practice_tests.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: new Column(children: <Widget>[
      new UserAccountsDrawerHeader(
        accountName: new Text("Firstname Lastname",
            style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0)),
        accountEmail: new Text(
          "firstname@lastname.com",
          style: new TextStyle(color: Colors.blueGrey[50]),
        ),
        currentAccountPicture: new CircleAvatar(
            backgroundColor: Colors.brown, child: new Text("FL")),
      ),
      new ListTile(
        title: new Text('Current Affairs'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CurrentAffairsScreen()),
          );
        },
      ),
      new ListTile(
        title: new Text('Study Materials'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudyMaterialsScreen()),
          );
        },
      ),
      new ListTile(
        title: new Text('Practice Tests'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PracticeTestsScreen()),
          );
        },
      ),
      new ListTile(
        title: new Text('Question Bank'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuestionBankScreen()),
          );
        },
      ),
      new Divider(),
      new ListTile(
        title: new Text('About'),
        onTap: () {},
      ),
    ]));
  }
}
