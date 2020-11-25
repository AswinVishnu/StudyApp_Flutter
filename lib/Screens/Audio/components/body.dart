import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  Body();

  @override
  AudioScreenState createState() => AudioScreenState();
}

class AudioScreenState extends State<Body> {

  AudioPlayer audioplayer1=new AudioPlayer();
  AudioPlayer audioplayer2=new AudioPlayer();
  Duration duration = new Duration();
  Duration position = new Duration();
  bool playing =false;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(

            children: <Widget>[

              Text(
                "First Audio",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: 20,
              ),
              slider(audioplayer1),

              InkWell(
                onTap: () {
                  getAudio("https://assets.mixkit.co/music/preview/mixkit-trip-hop-vibes-149.mp3",audioplayer1);
                },
                child: Icon(
                    playing==false
                        ? Icons.play_circle_outline
                        : Icons.pause_circle_outline,
                    size:80,
                    color: Colors.blue
                ),
              ),


              Text(
                "Second Audio",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                height: 20,
              ),
              slider(audioplayer2),

              InkWell(
                onTap: () {
                  getAudio("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",audioplayer2);
                },
                child: Icon(
                    playing==false
                        ? Icons.play_circle_outline
                        : Icons.pause_circle_outline,
                    size:80,
                    color: Colors.blue
                ),
              )
            ],

          ),
        ),
      ),
    );
  }



  Widget slider(AudioPlayer audioPlayer)
  {
    return Slider.adaptive(
        min: 0.0,
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            audioPlayer.seek(new Duration(seconds: value.toInt()));
          });
        }
    );
  }
  void getAudio(var audiourl,AudioPlayer audioPlayer) async{
    var url= audiourl;
    if(playing)
    {
      var res= await audioPlayer.pause();
      if(res==1)
      {
        setState(() {
          playing = false;
        });
      }
    }
    else{
      var res= await audioPlayer.play(url,isLocal: true);
      if(res==1)
      {
        setState(() {
          playing = true;
        });
      }

    }
    audioPlayer.onDurationChanged.listen((Duration dd) {
      setState(() {
        duration = dd;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        position = dd;
      });
    });
  }
}