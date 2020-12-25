import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/Screens/Home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/components/bottom_navigation.dart';

class ChangePasswordScreen extends StatefulWidget {
  final List userList;
  ChangePasswordScreen({Key key, @required this.userList}) : super(key: key);
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState(userList);
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  List userList;
  String emailId;
  String fullName;
  String currentpassword;
  String newpassword;
  String confirmpassword;
  String mobile;
  _ChangePasswordScreenState(this.userList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text('Change Password'),
      ),
      drawer: NavDrawer(userList: userList),
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[

                new Container(
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 40.0),

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
                                      'Current Password',
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
                                      currentpassword = value;
                                    },

                                    obscureText: true,

                                    //     enabled: !_status,
                                  ),
                                ),
                              ],
                            )),

                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 30.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'New Password',
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
                                      newpassword = value;
                                    },

                                    obscureText: true,

                                    //     enabled: !_status,
                                  ),
                                ),
                              ],
                            )),

                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 30.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Confirm Password',
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
                                      confirmpassword = value;
                                    },

                                    obscureText: true,

                                    //     enabled: !_status,
                                  ),
                                ),
                              ],
                            )),

                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 30.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Container(
                                      child: new RaisedButton(
                                        child: new Text("Update"),
                                        textColor: Colors.white,
                                        color: Colors.green,
                                        onPressed: () async {
                                          var jsonResponse;
                                          if (currentpassword == userList[4]) {

                                               if(newpassword==confirmpassword){
                                                    print("Password updated successfully");

                                                    Map data = {
                                                      "currentPassword":currentpassword,
                                                      "newPassword":newpassword,
                                                      "confirmPassword":confirmpassword
                                                    };
                                                    // final snackBar =
                                                    // new SnackBar(content: new Text('Loading...'));
                                                    // Scaffold.of(context).showSnackBar(snackBar);
                                                    final response = await http.post(
                                                        "https://oxystech-study-app-nodejs.herokuapp.com/changepassword/"+userList[0],
                                                        body: data);
                                                    if (response.statusCode == 200) {
                                                      print(json.decode(response.body));
                                                      Widget okButton = FlatButton(
                                                        child: Text("OK"),
                                                        onPressed: () {
                                                          Navigator.of(context).pop(false);
                                                        },
                                                      );
                                                      AlertDialog alert =  AlertDialog(
                                                        title: Text("Confirmation"),
                                                        content: Text("Password updated successfully"),
                                                        actions: [
                                                          okButton,
                                                        ],
                                                      );
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return alert;
                                                        },
                                                      );
                                                    }
                                                    else{

                                                      throw Exception('Failed to update');
                                                    }

                                                }
                                            else{

                                              Widget okButton = FlatButton(
                                                child: Text("OK"),
                                                onPressed: () {
                                                  Navigator.of(context).pop(false);
                                                },
                                              );
                                              AlertDialog alert =  AlertDialog(
                                                title: Text("Failed"),
                                                content: Text("New Password and Confirm Password does not match"),
                                                actions: [
                                                  okButton,
                                                ],
                                              );
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            }

                                          }
                                          else{
                                            print("Please enter correct password");
                                            Widget okButton = FlatButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                Navigator.of(context).pop(false);
                                              },
                                            );
                                            AlertDialog alert = AlertDialog(
                                              title: Text("Failed"),
                                              content: Text("Please enter correct password"),
                                              actions: [
                                                okButton,
                                              ],
                                            );
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          }
                                          if (fullName == null) {
                                            fullName = userList[1];
                                          }
                                          // Map data = {
                                          //   'fullname': fullName,
                                          //   'password': password,
                                          //   'role': 'student'
                                          // };
                                          //
                                          // print(data);
                                          // var response = await http.put(
                                          //     "https://oxystech-study-app-nodejs.herokuapp.com/user/account/" +
                                          //         userList[0],
                                          //     body: data);
                                          // if (response.statusCode == 200) {
                                          //   jsonResponse =
                                          //       json.decode(response.body);
                                          //   if (jsonResponse != null) {
                                          //     Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               HomeScreen(
                                          //                   userList: userList)),
                                          //     );
                                          //   }
                                          // }
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
