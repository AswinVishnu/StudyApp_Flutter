import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/Screens/Home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/components/bottom_navigation.dart';
import 'package:flutter_auth/Screens/Profile/change_password.dart';

class EditProfileScreen extends StatefulWidget {
  final List userList;
  EditProfileScreen({Key key, @required this.userList}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState(userList);
}

class _EditProfileState extends State<EditProfileScreen> {
  List userList;
  String emailId;
  String fullName;
  String password;
  String mobile;
  _EditProfileState(this.userList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Edit Profile'),
        ),
        drawer: NavDrawer(userList: userList),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: 220.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: new ExactAssetImage(
                                            'assets/images/'+userList[6]+'.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            // Padding(
                            //     padding:
                            //         EdgeInsets.only(top: 90.0, right: 100.0),
                            //     child: new Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: <Widget>[
                            //         new CircleAvatar(
                            //           backgroundColor: Colors.red,
                            //           radius: 25.0,
                            //           child: new Icon(
                            //             Icons.camera_alt,
                            //             color: Colors.white,
                            //           ),
                            //         )
                            //       ],
                            //     )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 5.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      onChanged: (value) {
                                        fullName = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText: userList[1],
                                      ),
                                      //       enabled: !_status,
                                      //        a`utofocus: !_status,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Gender',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      onChanged: (value) {
                                        mobile = value;
                                      },
                                      decoration: InputDecoration(
                                          hintText: userList[6]),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      onChanged: (value) {
                                        emailId = value;
                                      },
                                      decoration: InputDecoration(
                                          hintText: userList[3]),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                          // Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 25.0, right: 25.0, top: 10.0),
                          //     child: new Row(
                          //       mainAxisSize: MainAxisSize.max,
                          //       children: <Widget>[
                          //         new Column(
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           mainAxisSize: MainAxisSize.min,
                          //           children: <Widget>[
                          //             new Text(
                          //               'Password',
                          //               style: TextStyle(
                          //                   fontSize: 16.0,
                          //                   fontWeight: FontWeight.bold),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     )),
                          // Padding(
                          //     padding: EdgeInsets.only(
                          //         left: 25.0, right: 25.0, top: 2.0),
                          //     child: new Row(
                          //       mainAxisSize: MainAxisSize.max,
                          //       children: <Widget>[
                          //         new Flexible(
                          //           child: new TextField(
                          //             onChanged: (value) {
                          //               password = value;
                          //             },
                          //             decoration: InputDecoration(
                          //                 hintText: userList[4]),
                          //             obscureText: true,
                          //
                          //             //     enabled: !_status,
                          //           ),
                          //         ),
                          //       ],
                          //     )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      onChanged: (value) {
                                        mobile = value;
                                      },
                                      decoration: InputDecoration(
                                          hintText: userList[2]),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 10.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Institute',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      onChanged: (value) {
                                        mobile = value;
                                      },
                                      decoration: InputDecoration(
                                          hintText: userList[7]),
                                      enabled: false,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 10.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Container(
                                        child: new RaisedButton(
                                      child: new Text("Save"),
                                      textColor: Colors.white,
                                      color: Colors.green,
                                      onPressed: () async {
                                        var jsonResponse;
                                        if (password == null) {
                                          password = userList[4];
                                        }
                                        if (fullName == null) {
                                          fullName = userList[1];
                                        }
                                        Map data = {
                                          'fullname': fullName,
                                          'password': password,
                                          'role': 'student'
                                        };

                                        print(data);
                                        var response = await http.put(
                                            "https://oxystech-study-app-nodejs.herokuapp.com/user/account/" +
                                                userList[0],
                                            body: data);
                                        if (response.statusCode == 200) {
                                          jsonResponse =
                                              json.decode(response.body);
                                          if (jsonResponse != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeScreen(
                                                          userList: userList)),
                                            );
                                          }
                                        }
                                      },
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                    )),
                                  ),
                                  flex: 2,
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Container(
                                        child: new RaisedButton(
                                          child: new Text("Change Password"),
                                          textColor: Colors.white,
                                          color: Colors.lightBlue[900],
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ChangePasswordScreen(
                                                      userList: userList)),
                                            );
                                          },
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(20.0)),
                                        )),
                                  ),
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }
}
