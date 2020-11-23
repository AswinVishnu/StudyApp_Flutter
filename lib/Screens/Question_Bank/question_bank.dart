import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Question_Bank/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class QuestionBankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Question bank'),
      ),
      drawer: NavDrawer(),
      body: Body(),
    );
  }
}
