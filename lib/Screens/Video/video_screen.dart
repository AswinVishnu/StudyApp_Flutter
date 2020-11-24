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
    YoutubePlayerController _controller;
    YoutubePlayerController _controller2;
    @override
    void initState() {

      _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(videoURL1)
      );
      _controller2 = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(videoURL2)
      );

      super.initState();
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Video"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text("First Video"),
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                ),
                Text("Second Video"),
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