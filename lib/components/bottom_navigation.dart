import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/models/notifications.dart';
import 'package:flutter_auth/Screens/Notifications/notification_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_auth/Screens/Home/home.dart';
import 'package:flutter_auth/Screens/Profile/edit_profile.dart';


class BottomNavigation extends StatefulWidget {
  final List userList;
  BottomNavigation({Key key, @required this.userList}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState(userList);
}

class _BottomNavigationState extends State<BottomNavigation> {
  List userList;


  _BottomNavigationState(this.userList);

  int counter = 0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if(_selectedIndex==0)
      {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(userList: userList)),
        );
      }
    else if(_selectedIndex==1)
    {

    }
    else if(_selectedIndex==2)
    {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditProfileScreen(userList: userList)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Institute',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Profile',
        ),

      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );


  }

}