import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Current_Affairs/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class CurrentAffairsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Current Affairs'),
      ),
      drawer: NavDrawer(),
      body: Body(),
    );
  }
}
