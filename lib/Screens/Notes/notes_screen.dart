import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/components/expandable.dart';
//import 'package:flutter_auth/components/Notes.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/models/contents.dart';

class NotesScreen extends StatefulWidget {
  final List userList;

  var isLoading;
  NotesScreen({
    Key key,
    @required this.userList,
    @required this.isLoading,
  }) : super(key: key);
  @override
  _NotesState createState() =>
      _NotesState(userList, isLoading);
}

class _NotesState extends State<NotesScreen> {
  List userList;
  var isLoading;
  var list = [
    Contents(
        image: 'https://i.ytimg.com/vi/PQG_gYFePD4/maxresdefault.jpg',
        title: 'Tenses in English',
        description:
            'Present Uses --> 1: We use the present simple when something is generally or always true. • People need food. • It snows in winter here. • Two and two make four.    2: Similarly, we need to use this tense for a situation that we think is more or less permanent. (See the present continuous for temporary situations.)  • Where do you live?  • She works in a bank.  • I dont like mushrooms.  3: The next use is for habits or things that we do regularly. We often use adverbs of frequency (such as ‘often’, ‘always’ and ‘sometimes’) in this case, as well as expressions like ‘every Sunday’ or ‘twice a month’. (See the present continuous for new, temporary or annoying habits).  • Do you smoke?  • I play tennis every Tuesday.  • I dont travel very often',
        type: 'notes'),
    Contents(
        image: 'https://aptitude.brainkart.com/media/subject/article-Logical-Reasoning-3iC.jpg',
        title: 'Logical reasoning',
        description:
            'Two kinds of logical reasoning are often distinguished in addition to formal deduction: induction and abduction. Given a precondition or premise, a conclusion or logical consequence and a rule or material conditional that implies the conclusion given the precondition, one can explain the following. Deductive reasoning determines whether the truth of a conclusion can be determined for that rule, based solely on the truth of the premises. Example: "When it rains, things outside get wet. The grass is outside, therefore: when it rains, the grass gets wet." Mathematical logic and philosophical logic are commonly associated with this type of reasoning.  Inductive reasoning attempts to support a determination of the rule. It hypothesizes a rule after numerous examples are taken to be a conclusion that follows from a precondition in terms of such a rule. Example: "The grass got wet numerous times when it rained, therefore: the grass always gets wet when it rains." This type of reasoning is commonly associated with generalization from empirical evidence. While they may be persuasive, these arguments are not deductively valid: see the problem of induction.',
        type: 'notes'),
  ];
  _NotesState(this.userList, this.isLoading);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
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
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () {},
                    child: ListItem(list[index], context));
              }),
        ),
      ),
    );
  }
}

Widget ListItem(Contents list, BuildContext context) {
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
                          image: NetworkImage(list.image),
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
