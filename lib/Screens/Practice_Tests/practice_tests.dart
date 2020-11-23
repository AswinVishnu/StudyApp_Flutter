import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Practice_Tests/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class PracticeTestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Practice Test'),
      ),
      drawer: NavDrawer(),
      body: Body(),
    );
  }
}
