import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/expandable.dart';
import 'dart:math' as math;
import 'package:flutter_auth/components/currentaffairs.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
class CurrentAffairsScreen extends StatefulWidget {
  final List userList;
  CurrentAffairsScreen({
    Key key,
    @required this.userList,
  }) : super(key: key);
  @override
  _CurrentAffairsState createState() => _CurrentAffairsState(userList);
}

class _CurrentAffairsState extends State<CurrentAffairsScreen> {
  List userList;
  var list = [
    CurrentAffairs(img: 'assets/images/exams.png',
        title: 'Flutter tutorial',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        date: '25/02/2020'
    ),
    CurrentAffairs(img: 'assets/images/profile.jpg',
        title: 'Parliment News',
        description: 'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        date: '29/02/2020'
    ),

  ];
  _CurrentAffairsState(this.userList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Current Affairs'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Background(
        child: ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.blue,
            useInkWell: true,
          ),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {


                    },
                    child: ListItem(list[index],context)
                );
              }),

          // child: ListView(
          //   physics: const BouncingScrollPhysics(),
          //   children: <Widget>[
          //     Card1(),
          //     Card1()
          //     //Card2(),
          //     // Card3(),
          //   ],
          // ),
        ),
      ),
    );
  }
}


Widget ListItem(CurrentAffairs listItem,BuildContext context) {

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
                      image: AssetImage(
                          listItem.img),
                      fit: BoxFit.fill,
                    ),

                  ),
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
                        "Read more",
                        style: Theme.of(context).textTheme.body2,
                      )),
                  collapsed: Text(
                    listItem.description,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(5))
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              listItem.description,
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


