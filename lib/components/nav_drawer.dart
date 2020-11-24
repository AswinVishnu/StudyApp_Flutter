import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Study_Materials/study_materials.dart';
import 'package:flutter_auth/Screens/Home/home.dart';
import 'package:flutter_auth/Screens/Question_Bank/question_bank.dart';
import 'package:flutter_auth/Screens/Current_Affairs/current_affairs.dart';
import 'package:flutter_auth/Screens/Practice_Tests/practice_tests.dart';
import 'package:flutter_auth/Screens/Profile/edit_profile.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/Perfomance/perfomance.dart';

class NavDrawer extends StatefulWidget {
  final List userList;
  NavDrawer({Key key, @required this.userList}) : super(key: key);
  @override
  _NavDrawerState createState() => _NavDrawerState(userList);
}

class _NavDrawerState extends State<NavDrawer> {
  List userList;
  _NavDrawerState(this.userList);
  //call list element like userList[0]
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: new Column(children: <Widget>[
      new UserAccountsDrawerHeader(
        accountName: new Text(userList[1],
            style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0)),
        accountEmail: new Text(
          userList[3],
          style: new TextStyle(color: Colors.blueGrey[50]),
        ),
        currentAccountPicture: new CircleAvatar(
            backgroundColor: Colors.brown, child: new Text("FL")),
      ),
      new ListTile(
        title: new Text('Home'),
        leading: Icon(
          Icons.home,
          color: Color(0xFF6F35A5),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(userList: userList)),
          );
        },
      ),
      new ListTile(
        title: new Text('Current Affairs'),
        leading: Icon(
          Icons.pages,
          color: Color(0xFF6F35A5),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CurrentAffairsScreen(userList: userList)),
          );
        },
      ),
      new ListTile(
        leading: Icon(
          Icons.book,
          color: Color(0xFF6F35A5),
        ),
        title: new Text('Study Materials'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudyMaterialsScreen(userList: userList)),
          );
        },
      ),
      new ListTile(
        title: new Text('Practice Tests'),
        leading: Icon(
          Icons.accessibility_new,
          color: Color(0xFF6F35A5),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PracticeTestsScreen(userList: userList)),
          );
        },
      ),
      new ListTile(
        title: new Text('Question Bank'),
        leading: Icon(
          Icons.flag,
          color: Color(0xFF6F35A5),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuestionBankScreen(userList: userList)),
          );
        },
      ),
      new ListTile(
        title: new Text('Perfomance'),
        leading: Icon(
          Icons.backpack,
          color: Color(0xFF6F35A5),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PerfomanceScreen(userList: userList)),
          );
        },
      ),
      new ListTile(
        title: new Text('Edit Profile'),
        leading: Icon(
          Icons.accessibility,
          color: Color(0xFF6F35A5),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditProfileScreen(userList: userList)),
          );
        },
      ),
      new Divider(),
      new ListTile(
        title: new Text('SignOut'),
        leading: Icon(
          Icons.logout,
          color: Color(0xFF6F35A5),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        },
      ),
    ]));
  }
}
