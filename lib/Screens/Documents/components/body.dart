import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';


import 'package:audioplayers/audioplayers.dart';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  final List documentList;
  int index;
  Body({Key key, @required this.documentList, @required this.index})
      : super(key: key);

  @override
  DocumentState createState() => DocumentState(documentList, index);
}

class DocumentState extends State<Body> {
  List documentList;
  int index;
  bool _isLoading = true;
  PDFDocument doc;

  DocumentState(this.documentList, this.index);


  @override
  void initState () {

    setState(() {
      _isLoading = true;
    });
    getURL();
  }

  getURL() async
  {
    doc = await PDFDocument.fromURL(
        'http://www.pdf995.com/samples/pdf.pdf');
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

