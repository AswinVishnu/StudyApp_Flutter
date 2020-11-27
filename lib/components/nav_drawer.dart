import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Study_Materials/study_materials.dart';
import 'package:flutter_auth/Screens/Home/home.dart';
import 'package:flutter_auth/Screens/Question_Bank/question_bank.dart';
import 'package:flutter_auth/Screens/Current_Affairs/current_affairs.dart';
import 'package:flutter_auth/Screens/Practice_Tests/practice_tests.dart';

import 'package:flutter_auth/Screens/Profile/edit_profile.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/Perfomance/perfomance.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_auth/Screens/Video/video_screen.dart';
import 'package:flutter_auth/Screens/Audio/audio_screen.dart';
import 'package:flutter_auth/components/question.dart';
import 'package:flutter_auth/components/currentaffairs.dart';
import 'package:flutter_auth/components/audio.dart';
import 'package:flutter_auth/components/video.dart';

class NavDrawer extends StatefulWidget {
  final List userList;
  NavDrawer({Key key, @required this.userList}) : super(key: key);
  @override
  _NavDrawerState createState() => _NavDrawerState(userList);
}

class _NavDrawerState extends State<NavDrawer> {
  List<Question> questionsList = List();
  List<CurrentAffairs> currentAffairsList = List();
  List<Video> videosList = List();
  List<Audio> audiosList = List();
  var isLoading = false;
  List userList;

  _NavDrawerState(this.userList);

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
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          final response = await http.get(
              "https://oxystech-study-app-nodejs.herokuapp.com/admin/current_affairs");
          if (response.statusCode == 200) {
            currentAffairsList = (json.decode(response.body) as List)
                .map((data) => new CurrentAffairs.fromJson(data))
                .toList();
            setState(() {
              isLoading = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CurrentAffairsScreen(
                      userList: userList,
                      currentAffairsList: currentAffairsList,
                      isLoading: isLoading)),
            );
          } else {
            throw Exception('Failed to load quetions');
          }
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
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          final response = await http.get(
              "https://oxystech-study-app-nodejs.herokuapp.com/admin/question");
          if (response.statusCode == 200) {
            questionsList = (json.decode(response.body) as List)
                .map((data) => new Question.fromJson(data))
                .toList();
            setState(() {
              isLoading = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => QuestionBankScreen(
                      userList: userList,
                      questionList: questionsList,
                      isLoading: isLoading)),
            );
          } else {
            throw Exception('Failed to load quetions');
          }
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
        onTap: () async {
          var jsonResponse;
          var response = await http.get(
              "https://oxystech-study-app-nodejs.herokuapp.com/user/account/" +
                  userList[0]);
          if (response.statusCode == 200) {
            jsonResponse = json.decode(response.body);
            List newList = [];
            newList.add(jsonResponse['result']['_id']);
            newList.add(jsonResponse['result']['fullname']);
            newList.add(jsonResponse['result']['mobile'].toString());
            newList.add(jsonResponse['result']['email']);
            newList.add(jsonResponse['result']['password']);
            if (jsonResponse != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfileScreen(userList: newList)),
              );
            }
          }
        },
      ),
      new ListTile(
        title: new Text('Videos'),
        leading: Icon(
          Icons.backpack,
          color: Color(0xFF6F35A5),
        ),
        onTap: () async {
          setState(() {
            isLoading = true;
          });

          Map data = {"type": "video"};

          final response = await http.post(
              "https://oxystech-study-app-nodejs.herokuapp.com/admin/content/type",
              body: data);
          if (response.statusCode == 200) {
            videosList = (json.decode(response.body) as List)
                .map((data1) => new Video.fromJson(data1))
                .toList();
            setState(() {
              isLoading = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoScreen(
                      userList: userList,
                      videosList: videosList,
                      isLoading: isLoading)),
            );
          } else {
            throw Exception('Failed to load videos');
          }
        },
      ),
      new ListTile(
        title: new Text('Audios'),
        leading: Icon(
          Icons.backpack,
          color: Color(0xFF6F35A5),
        ),
        onTap: () async {
          setState(() {
            isLoading = true;
          });

          Map data = {"type": "audio"};

          final response = await http.post(
              "https://oxystech-study-app-nodejs.herokuapp.com/admin/content/type",
              body: data);
          if (response.statusCode == 200) {
            audiosList = (json.decode(response.body) as List)
                .map((data1) => new Audio.fromJson(data1))
                .toList();
            setState(() {
              isLoading = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AudioScreen(
                      userList: userList,
                      audiosList: audiosList,
                      isLoading: isLoading)),
            );
          } else {
            throw Exception('Failed to load audios');
          }
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
