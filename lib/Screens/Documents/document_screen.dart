import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_auth/models/contents.dart';

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
        type: 'Video'),
    Contents(
        image: 'assets/images/studymaterials.jpg',
        title: 'Apps from scratch travel UI tutorial',
        url: 'https://www.youtube.com/watch?v=CSa6Ocyog4U',
        type: 'Video')
  ];
  String videoURL1 = "https://www.youtube.com/watch?v=n8X9_MgEdCg";
  String videoURL2 = "https://www.youtube.com/watch?v=CSa6Ocyog4U";
  YoutubePlayerController _controller1;
  YoutubePlayerController _controller2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {}, child: ListItem(list[index]));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ListItem(Contents listItem) {
    _controller1 = YoutubePlayerController(
        initialVideoId:
            YoutubePlayer.convertUrlToId(listItem.url), // id youtube video
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ));
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text(
            listItem.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            height: 30,
          ),
          YoutubePlayer(
            controller: _controller1,
            showVideoProgressIndicator: true,
          ),
        ],
      ),
    );
  }
}
