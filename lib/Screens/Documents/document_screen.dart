import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/models/document.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_auth/Screens/Documents/components/body.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';

class DocumentScreen extends StatefulWidget {
  final List userList;
  final List documentsList;
  var isLoading;
  DocumentScreen({
    Key key,
    @required this.userList,
    @required this.documentsList,
    @required this.isLoading,
  }) : super(key: key);

  @override
  DocumentScreenState createState() => DocumentScreenState(userList, documentsList, isLoading);
}

class DocumentScreenState extends State<DocumentScreen> {
  List userList;
  var isLoading;
  List documentsList;
  DocumentScreenState(this.userList, this.documentsList, this.isLoading);


  bool _isLoading = true;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text("Documents"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: documentsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          splashColor: Colors.blue,

                          highlightColor: Colors.blue.withOpacity(0.9),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Body(documentsList: documentsList, index: index)),
                            );
                          },
                          child: ListItem(documentsList[index]));

                    }),
              ),
            ),
          ],
        ),
      ),

    );
  }

  Widget ListItem(Documents listItem) {

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            leading: Icon(Icons.text_snippet,size: 50),
            title: Text(listItem.title, style: TextStyle(fontSize: 20.0)),
          ),


        ],
      ),
    );
  }
}
