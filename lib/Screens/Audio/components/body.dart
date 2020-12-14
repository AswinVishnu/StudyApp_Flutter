import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/audio.dart';

import 'package:audioplayers/audioplayers.dart';


import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  final List audioList;
  int index;
  Body({Key key, @required this.audioList, @required this.index})
      : super(key: key);

  @override
  AudioScreenState createState() => AudioScreenState(audioList, index);
}

class AudioScreenState extends State<Body> {
  List audioList;
  int index;


  AudioScreenState(this.audioList, this.index);
  AudioPlayer audioPlayer = new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();
  bool playing = false;
  //var audiourl = 'https://assets.mixkit.co/music/preview/mixkit-trip-hop-vibes-149.mp3';

  @override
  void dispose() {
    // TODO: implement dispose
    if(audioPlayer!=null) {

      audioPlayer.stop();
      audioPlayer.dispose();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Background(
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.network(
                  'https://www.frostfireaudio.com.au/wp-content/uploads/2018/02/headphone_audio.jpg',

                ),
                SizedBox(height: 20),
                slider(),
                InkWell(
                    onTap: (){
                      getAudio();
                    },
                    child: Icon(
                      playing==false
                          ? Icons.play_circle_outline
                          : Icons.pause_circle_outline,
                      size:100,
                      color: Colors.blue,
                    ),
                )
              ],

            ),
          ),
        ),
      ),
    );
  }




  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.black,
        inactiveColor: Colors.pink,
        value: position.inSeconds.toDouble(),
        min: 0.0,
        max: duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            audioPlayer.seek(new Duration(seconds: value.toInt()));
          });
        });
  }

  void getAudio() async{


    if(playing) {

      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
        });
      }
    }else{
        var res=await audioPlayer.play(baseURL+audioList[index].file);
        if(res==1){
          setState(() {
            playing=true;
          });
        }
      }

      audioPlayer.onDurationChanged.listen((Duration dd){
        setState(() {
          duration=dd;
        });
      });

      audioPlayer.onAudioPositionChanged.listen((Duration dd){
        setState(() {
          position=dd;
        });
      });
    }
  }






