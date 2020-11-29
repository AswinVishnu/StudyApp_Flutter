import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/Screens/Home/components/expansiontile.dart';
import 'package:flutter_auth/models/contents.dart';
import 'package:flutter_auth/Screens/Video/video_screen.dart';
import 'package:flutter_auth/Screens/Audio/audio_screen.dart';
import 'package:flutter_auth/Screens/Documents/document_screen.dart';
import 'package:flutter_auth/models/category.dart';

class Body extends StatefulWidget {
  List userList;
  List categoryList;
  var isLoading;

  Body({
    Key key,
    @required this.userList,
    @required this.categoryList,
    @required this.isLoading,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState(userList, categoryList, isLoading);
}

class _BodyState extends State<Body> {
  List userList;
  
  List categoryList;
  List<Contents> videosList = List();
  List<Contents> audiosList = List();
  var isLoading = false;

  _BodyState(this.userList, this.categoryList, this.isLoading);
  // var list = [
  //   Contents(
  //     category: 'General Knowledge',
  //   ),
  //   Contents(
  //     category: 'Analytical Reasoning',
  //   ),
  //   Contents(
  //     category: 'English',
  //   ),
  //   Contents(
  //     category: 'Mathematics',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {

    return Background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: categoryList.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                          onTap: () {}, child: ListItem(categoryList[index],context));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ListItem(Category listItem, BuildContext context) {
    return ExpansionTile(
      title: Text(
        listItem.name,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      children: <Widget>[
        InkWell(

          splashColor: Colors.blue,

          highlightColor: Colors.blue.withOpacity(0.9),
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
                  .map((data1) => new Contents.fromJson(data1))
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
          child: ListTile(
            title: Text('Videos'),
          ),
        ),
        InkWell(
          splashColor: Colors.blue,

          highlightColor: Colors.blue.withOpacity(0.9),
          onTap: () async{

            setState(() {
              isLoading = true;
            });

            Map data = {"type": "audio"};

            final response = await http.post(
                "https://oxystech-study-app-nodejs.herokuapp.com/admin/content/type",
                body: data);
            if (response.statusCode == 200) {
              audiosList = (json.decode(response.body) as List)
                  .map((data1) => new Contents.fromJson(data1))
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
            }
          },
          child: ListTile(
            title: Text('Audio'),
          ),
        ),
        InkWell(
          splashColor: Colors.blue,

          highlightColor: Colors.blue.withOpacity(0.9),
          onTap: (){


              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocumentScreen()),
              );

          },
          child: ListTile(
            title: Text('Documents'),
          ),
        ),
      ],
    );
  }


}
