import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Home/components/griddashboard.dart';
import 'package:flutter_auth/Screens/Video/video_screen.dart';
import 'package:flutter_auth/Screens/Audio/audio_screen.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          GridDashboard(),



        ],
      ),
    );
  }
}
