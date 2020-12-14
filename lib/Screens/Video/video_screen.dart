import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter_auth/components/video.dart';
import 'package:flutter_auth/models/contents.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';
import 'package:flutter_auth/models/video.dart';

class VideoScreen extends StatefulWidget {
  final List userList;
  final List videosList;
  var isLoading;

  VideoScreen({
    Key key,
    @required this.userList,
    @required this.videosList,
    @required this.isLoading,
  }) : super(key: key);

  @override
  VideoScreenState createState() =>
      VideoScreenState(userList, videosList, isLoading);
}

class VideoScreenState extends State<VideoScreen> {
  List userList;
  List videosList;
  var isLoading;

  YoutubePlayerController _controller1;
  YoutubePlayerController _controller2;

  VideoScreenState(this.userList, this.videosList, this.isLoading);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Text("Video"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: videosList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {}, child: ListItem(videosList[index]));
                    }),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }

  Widget ListItem(Videos listItem) {
    _controller1 = YoutubePlayerController(
        initialVideoId:
            YoutubePlayer.convertUrlToId(listItem.videoLink), // id youtube video
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
