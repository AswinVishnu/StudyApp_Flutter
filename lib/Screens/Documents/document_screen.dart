import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/models/contents.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_auth/Screens/Documents/components/body.dart';

class DocumentScreen extends StatefulWidget {
  DocumentScreen();

  @override
  DocumentScreenState createState() => DocumentScreenState();
}

class DocumentScreenState extends State<DocumentScreen> {
  var list = [
    Contents(
        image: 'assets/images/exams.png',
        title: 'Flutter tutorial',
        url: 'https://www.youtube.com/watch?v=BE9ATY2Ygas',
        type: 'pdf'),
    Contents(
        image: 'assets/images/studymaterials.jpg',
        title: 'Apps from scratch travel UI tutorial',
        url: 'https://www.youtube.com/watch?v=CSa6Ocyog4U',
        type: 'pdf')
  ];

  bool _isLoading = true;
  PDFDocument doc;
  Contents documentList;
  void _loadFromUrl() async {
    setState(() {
      _isLoading = true;
    });
    doc = await PDFDocument.fromURL(
        'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Documents"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          splashColor: Colors.blue,

                          highlightColor: Colors.blue.withOpacity(0.9),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Body(documentList: list, index: index)),
                            );
                          },
                          child: ListItem(list[index]));

                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ListItem(Contents listItem) {

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
