import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Home Page'),
      ),
      drawer: NavDrawer(),
      body: Body(),
    );
  }
}
