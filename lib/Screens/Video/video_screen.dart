import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen();

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
    String videoURL1 = "https://www.youtube.com/watch?v=n8X9_MgEdCg";
    String videoURL2 = "https://www.youtube.com/watch?v=CSa6Ocyog4U";
    YoutubePlayerController _controller1;
    YoutubePlayerController _controller2;
    VideoItems item1 = new VideoItems(
        title: "Flutter tutorial", url: "https://www.youtube.com/watch?v=BE9ATY2Ygas");

    VideoItems item2 = new VideoItems(
      title: "Apps from scratch travel UI tutorial",
      url: "https://www.youtube.com/watch?v=CSa6Ocyog4U",
    );


    @override
    Widget build(BuildContext context) {
      List<VideoItems> myList = [item1, item2];

      _controller1 = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(item1.url), // id youtube video
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ));
      _controller2 = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(item2.url), // id youtube video
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ));
      return Scaffold(
        appBar: AppBar(
          title: Text("Video"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                SizedBox(
                  height: 40,
                ),
                Text(
                  item1.title,
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
                SizedBox(
                  height: 30,
                ),
                Text(
                  item2.title,
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
                  controller: _controller2,
                  showVideoProgressIndicator: true,
                ),

              ],
            ),
          ),
        ),
      );
    }
}

class VideoItems {
  String title;
  String url;
  VideoItems({this.title, this.url});
}