import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';


import 'package:audioplayers/audioplayers.dart';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/constants.dart';

class Body extends StatefulWidget {
  final List documentsList;
  int index;
  Body({Key key, @required this.documentsList, @required this.index})
      : super(key: key);

  @override
  DocumentState createState() => DocumentState(documentsList, index);
}

class DocumentState extends State<Body> {
  List documentsList;
  int index;
  bool _isLoading = true;
  PDFDocument doc;

  DocumentState(this.documentsList, this.index);


  @override
  void initState () {

    setState(() {
      _isLoading = true;
    });
    getURL();
  }

  getURL() async
  {
    doc = await PDFDocument.fromURL(baseURL+documentsList[index].file);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: doc)
      ),
    );
  }


}

