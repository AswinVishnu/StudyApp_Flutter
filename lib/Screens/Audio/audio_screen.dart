import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Audio/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/audio.dart';
import 'package:flutter_auth/components/question.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AudioScreen extends StatefulWidget {
  final List userList;
  AudioScreen({Key key, @required this.userList}) : super(key: key);

  @override
  _AudioState createState() => _AudioState(userList);
}

class _AudioState extends State<AudioScreen> {
  List userList;

  var isLoading;
  var response = "[{_id: 5f9bc035a9c81d00243f2f4b, question: What is AZ-900 certification?, content: other, optionA: Azure, optionB: AWC, optionC: GCP, optionD: Heroku, answer: Azure, status: true}, {_id: 5f9bdb840dd7a4002416a89d, question: Where is kerala?, content: Current Affire 2020, optionA: Pakistan, optionB: India, optionC: Singapoor, optionD: Maleshya, answer: India, status: true}, {_id: 5f9c00030dd7a4002416a8a2, question: What is your name?, content: Current Affire 2020, optionA: Afsal, optionB: bbb, optionC: aa, optionD: ss, answer: Current Affire 2020, status: true}]";
  var list = [
    Audio(img: 'assets/images/exams.png',
        title: 'Learn about tenses',
        path: 'audio/mixkit-trip-hop-vibes-149.mp3',
        type: 'Audio'
    ),
    Audio(img: 'assets/images/studymaterials.jpg',
        title: 'How to prepare for PSC',
        path: 'audio/Audio1.mp3',
        type: 'Audio'
    ),
    Audio(img: 'assets/images/profile.jpg',
        title: 'Easy way to crack Analytical reasoning questions',
        path: 'audio/Audio2.mp3',
        type: 'Audio'
    ),
    Audio(img: 'assets/images/CurrentAffairs.png',
        title: 'Prepare for Logical reasoning',
        path: 'audio/Audio3.mp3',
        type: 'Audio'
    )

  ];
  _AudioState(this.userList);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: new AppBar(
        title: new Text('Audio'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Background(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Body(

                              audioList: list,
                              index: index)),
                    );

                  },
                  child: ListItem(list[index])
              );
            }),
      ),
    );
  }

  Widget ListItem(Audio listItem) {
    return Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0),
         Text(
          listItem.title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),

      ],
        ),
    );
  }


}
