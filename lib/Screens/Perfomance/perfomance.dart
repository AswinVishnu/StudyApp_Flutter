import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';

class PerfomanceScreen extends StatefulWidget {
  List userList;
  PerfomanceScreen({
    Key key,
    @required this.userList,
  }) : super(key: key);
  @override
  _PerfomanceState createState() => _PerfomanceState(userList);
}

class _PerfomanceState extends State<PerfomanceScreen> {
  List userList;

  _PerfomanceState(this.userList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Perfomance Page'),
        ),
        drawer: NavDrawer(userList: userList),
        body: ListView(children: <Widget>[
          DataTable(
            columns: [
              DataColumn(label: Text('Exam Name')),
              DataColumn(label: Text('Attended On')),
              DataColumn(label: Text('Score')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Exam 1')),
                DataCell(Text('29-10-2020')),
                DataCell(Text('25/30')),
              ]),
              DataRow(cells: [
                DataCell(Text('Exam 2')),
                DataCell(Text('30-10-2020')),
                DataCell(Text('20/30')),
              ]),
              DataRow(cells: [
                DataCell(Text('Exam 3')),
                DataCell(Text('22-10-2020')),
                DataCell(Text('45/50')),
              ]),
              DataRow(cells: [
                DataCell(Text('Exam 4')),
                DataCell(Text('10-11-2020')),
                DataCell(Text('65/80')),
              ]),
            ],
          ),
        ]));
  }
}
