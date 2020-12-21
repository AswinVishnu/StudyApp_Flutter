import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_auth/Screens/Login/components/background.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_auth/models/video.dart';
import 'package:flutter_auth/models/audio.dart';
import 'package:flutter_auth/models/notes.dart';
import 'package:flutter_auth/Screens/Video/video_screen.dart';
import 'package:flutter_auth/Screens/Audio/audio_screen.dart';
import 'package:flutter_auth/Screens/Documents/document_screen.dart';
import 'package:flutter_auth/models/category.dart';
import 'package:flutter_auth/models/document.dart';
import 'package:flutter_auth/Screens/Notes/notes_screen.dart';

class Body extends StatefulWidget {
  final List userList;
  final List categoryList;
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
  List<Videos> videosList = List();
  List<Audio> audiosList = List();
  List<Notes> notesList = List();
  List<Documents> documentsList = List();
  var isLoading = false;

  _BodyState(this.userList, this.categoryList, this.isLoading);


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
                          onTap: () {}, child: ListItem(categoryList[index].name,context));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ListItem(String listItem, BuildContext context) {
    return ExpansionTile(
      title: Text(
        listItem,
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

            Map data = {"type": "video","category": listItem};
            final snackBar = new SnackBar(content: new Text('Loading...'));
            Scaffold.of(context).showSnackBar(snackBar);
            final response = await http.post(
                "https://oxystech-study-app-nodejs.herokuapp.com/admin/content/type",
                body: data,headers: { 'Authorization': 'Bearer '+userList[5]});
            if (response.statusCode == 200) {
              videosList = (json.decode(response.body) as List)
                  .map((data1) => new Videos.fromJson(data1))
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

            Map data = {"type": "audio","category": listItem};
            final snackBar = new SnackBar(content: new Text('Loading...'));
            Scaffold.of(context).showSnackBar(snackBar);
            final response = await http.post(
                "https://oxystech-study-app-nodejs.herokuapp.com/admin/content/type",
                body: data, headers: { 'Authorization': 'Bearer '+userList[5]});
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
            }
          },
          child: ListTile(
            title: Text('Audio'),
          ),
        ),
        InkWell(
          splashColor: Colors.blue,

          highlightColor: Colors.blue.withOpacity(0.9),
          onTap: () async{

            Map data = {"type": "document","category": listItem};
            final snackBar = new SnackBar(content: new Text('Loading...'));
            Scaffold.of(context).showSnackBar(snackBar);
            final response = await http.post(
                "https://oxystech-study-app-nodejs.herokuapp.com/admin/content/type",
                body: data,headers: { 'Authorization': 'Bearer '+userList[5]});
              if (response.statusCode == 200) {
                documentsList = (json.decode(response.body) as List)
                    .map((data1) => new Documents.fromJson(data1))
                    .toList();
                print(json.decode(response.body));

                setState(() {
                  isLoading = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DocumentScreen(
                          userList: userList,
                          documentsList: documentsList,
                          isLoading: isLoading)),
                );

              }
          },
          child: ListTile(
            title: Text('Documents'),
          ),
        ),
        InkWell(
          splashColor: Colors.blue,

          highlightColor: Colors.blue.withOpacity(0.9),
          onTap: () async{

            setState(() {
              isLoading = true;
            });

            Map data = {"type": "note","category": listItem};
            final snackBar = new SnackBar(content: new Text('Loading...'));
            Scaffold.of(context).showSnackBar(snackBar);
            final response = await http.post(
                "https://oxystech-study-app-nodejs.herokuapp.com/admin/content/type",
                body: data, headers: { 'Authorization': 'Bearer '+userList[5]});
            if (response.statusCode == 200) {
              notesList = (json.decode(response.body) as List)
                  .map((data1) => new Notes.fromJson(data1))
                  .toList();
              
              setState(() {
                isLoading = false;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotesScreen(
                        userList: userList,
                        notesList: notesList,
                        isLoading: isLoading)),
              );
            } else {
              throw Exception('Failed to load Notes');
            }
          },
          child: ListTile(
            title: Text('Notes'),
          ),
        ),
      ],
    );
  }


}
