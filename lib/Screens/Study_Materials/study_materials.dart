import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Study_Materials/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class StudyMaterialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Study Materials'),
      ),
      drawer: NavDrawer(),
      body: Body(),
    );
  }
}
