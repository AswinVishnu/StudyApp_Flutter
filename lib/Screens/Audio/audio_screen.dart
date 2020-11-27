import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Audio/components/body.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/audio.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';


class AudioScreen extends StatefulWidget {
  final List userList;
  final List audiosList;
  var isLoading;
  AudioScreen({
    Key key,
    @required this.userList,
    @required this.audiosList,
    @required this.isLoading,
  }) : super(key: key);

  @override
  _AudioState createState() =>
      _AudioState(userList, audiosList, isLoading);
}
}

class _AudioState extends State<AudioScreen> {
   List userList;
  List audiosList;
  var isLoading;

  _AudioState(this.userList, this.audiosList, this.isLoading);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: new AppBar(
        title: new Text('Audio'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Background(
        child: ListView.builder(
            itemCount: audiosList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Body(

                              audioList: audiosList,
                              index: index)),
                    );

                  },
                  child: ListItem(audiosList[index])
              );
            }),
      ),
    );
  }

  Widget ListItem(Audio listItem) {
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
