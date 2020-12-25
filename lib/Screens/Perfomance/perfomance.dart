import 'package:flutter/material.dart';
import 'package:flutter_auth/components/nav_drawer.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/components/bottom_navigation.dart';
import 'package:flutter_auth/models/performance.dart';

class PerfomanceScreen extends StatefulWidget {
  List userList;
  List performanceList;
  PerfomanceScreen({
    Key key,
    @required this.userList,
    @required this.performanceList,
  }) : super(key: key);
  @override
  _PerfomanceState createState() => _PerfomanceState(userList,performanceList);
}

class _PerfomanceState extends State<PerfomanceScreen> {
  List userList;
  List performanceList;
  _PerfomanceState(this.userList,this.performanceList);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue,
          title: new Text('Perfomance Page'),
        ),
        drawer: NavDrawer(userList: userList),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Container(
            color: Colors.white,

            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Exam Name')),
                    DataColumn(label: Text('Attended On')),
                    DataColumn(label: Text('Score')),
                  ],
                  rows: List.generate(
                      performanceList.length, (index) => _getDataRow(performanceList[index])),
                ),
              ),
            ),
          ),
        ),

    );
  }

  DataRow _getDataRow(Performance result) {
    return DataRow(
      cells: <DataCell>[

        DataCell(Text(result.examName)),
        DataCell(Text(result.attendedOn)),
        DataCell(Text(result.score)),

      ],
    );
  }
}
