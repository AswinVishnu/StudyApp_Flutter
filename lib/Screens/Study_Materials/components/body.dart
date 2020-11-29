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
  var isLoading;

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
                          onTap: () {}, child: ListItem(categoryList[index]));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ListItem(Contents listItem) {
    return ExpansionTile(
        title: Text(
          listItem.category,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        children: getContents());
  }

  List<Widget> getContents() {
    return <Widget>[
      ListTile(
        title: Text('Videos'),
      ),
      ListTile(
        title: Text('Audio'),
      ),
      ListTile(
        title: Text('Notes'),
      ),
      ListTile(
        title: Text('Documents'),
      )
    ];
  }
}
