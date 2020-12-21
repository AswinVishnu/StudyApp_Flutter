import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/expandable.dart';
//import 'package:flutter_auth/components/currentaffairs.dart';
import 'package:flutter_auth/models/contents.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/models/currentaffairs.dart';

class InstituteScreen extends StatefulWidget {
  final List userList;
  final List instituteDetails;

  InstituteScreen({
    Key key,
    @required this.userList,
    @required this.instituteDetails,

  }) : super(key: key);
  @override
  _InstituteState createState() =>
      _InstituteState(userList, instituteDetails);
}

class _InstituteState extends State<InstituteScreen> {
  List userList;
  List instituteDetails;

  // var list = [
  //   CurrentAffairs(
  //       img: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
  //       title: 'Flutter tutorial',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  //       date: '25/02/2020'),
  //   CurrentAffairs(
  //       img: 'https://homepages.cae.wisc.edu/~ece533/images/boat.png',
  //       title: 'Parliment News',
  //       description:
  //           'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  //       date: '29/02/2020'),
  // ];
  _InstituteState(this.userList, this.instituteDetails);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: new Text('Institute'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Background(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 0, 35, 70),


              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[


                  SizedBox(
                      height: 250,
                      width: 250,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(baseURL+instituteDetails[4]),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 80.0),
                      leading: Icon(Icons.school),
                      title: Text(instituteDetails[0]),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 80.0),
                      leading: Icon(Icons.home),
                      title: Text(instituteDetails[3]),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 80.0),
                      leading: Icon(Icons.attach_email),
                      title: Text(instituteDetails[1]),
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 80.0),
                      leading: Icon(Icons.mobile_friendly),
                      title: Text(instituteDetails[2]),
                    ),

                  ],
                ),
              ),

          )
      ),
      bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }
}

Widget ListItem(CurrentAffairs currentAffairsList, BuildContext context) {
  return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(baseURL+currentAffairsList.image),
                          fit: BoxFit.fill)),
                ),
              ),
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        currentAffairsList.date.substring(0,16)+"                                               Read more",
                        style: Theme.of(context).textTheme.body2,
                      )),
                  collapsed: Text(
                    currentAffairsList.description,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            currentAffairsList.description,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          )),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ));
}
