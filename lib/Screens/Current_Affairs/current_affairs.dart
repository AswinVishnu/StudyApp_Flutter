import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/expandable.dart';
import 'package:flutter_auth/components/currentaffairs.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';

class CurrentAffairsScreen extends StatefulWidget {
  final List userList;
  final List currentAffairsList;
  var isLoading;
  CurrentAffairsScreen({
    Key key,
    @required this.userList,
    @required this.currentAffairsList,
    @required this.isLoading,
  }) : super(key: key);
  @override
  _CurrentAffairsState createState() =>
      _CurrentAffairsState(userList, currentAffairsList, isLoading);
}

class _CurrentAffairsState extends State<CurrentAffairsScreen> {
  List userList;
  List currentAffairsList;
  var isLoading;
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
  _CurrentAffairsState(this.userList, this.currentAffairsList, this.isLoading);
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
              itemCount: currentAffairsList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {},
                    child: ListItem(currentAffairsList[index], context));
              }),
        ),
      ),
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
                      image: NetworkImage(currentAffairsList.image),
                      fit: BoxFit.cover)),
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
                currentAffairsList.description,
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
