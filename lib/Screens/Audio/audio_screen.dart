import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Audio/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class AudioScreen extends StatefulWidget {
  final List userList;
  AudioScreen({Key key, @required this.userList}) : super(key: key);

  @override
  _AudioState createState() => _AudioState(userList);
}

class _AudioState extends State<AudioScreen> {
  List userList;
  _AudioState(this.userList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Audio'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Body(),
    );
  }
}
