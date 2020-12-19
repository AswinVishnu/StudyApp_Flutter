import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/expandable.dart';
import 'package:flutter_auth/models/notes.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/models/contents.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';

class NotesScreen extends StatefulWidget {
  final List userList;
  final List notesList;
  var isLoading;

  NotesScreen({
    Key key,
    @required this.userList,
    @required this.notesList,
    @required this.isLoading,
  }) : super(key: key);
  @override
  _NotesState createState() => _NotesState(userList, notesList, isLoading);
}

class _NotesState extends State<NotesScreen> {
  List userList;
  var isLoading;
  List notesList;

  _NotesState(this.userList, this.notesList, this.isLoading);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: new Text('Notes'),
      ),
      drawer: NavDrawer(userList: userList),
      body: Background(
        child: ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.blue,
            useInkWell: true,
          ),
          child: ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {}, child: ListItem(notesList[index], context));
              }),
        ),
      ),
      bottomNavigationBar: BottomNavigation(userList: userList),
    );
  }
}

Widget ListItem(Notes list, BuildContext context) {
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
                      image: NetworkImage(baseURL+list.image), fit: BoxFit.fill)),
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
                list.description,
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
                        list.description,
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
