import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_auth/Screens/Study_Materials/subjects.dart';

class Expansiontile extends StatelessWidget {
  var jsonResponse = null;
  var listItems = [
    Subject(category: "General Knowledge", subcategories: [SubCategory(subcategory: "Current Affairs"),
      SubCategory(subcategory: "History")]
    ),
    Subject(category: "English", subcategories: [SubCategory(subcategory: "Tenses"),
      SubCategory(subcategory: "Nouns")]
    ),
    Subject(category: "Analytical reasoning", subcategories: [SubCategory(subcategory: "Puzzles"),
      SubCategory(subcategory: "Seating Arrangement")]
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Expansion Tile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: listItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return InkWell(
                          onTap: () {
                            print("$index");
                          },
                          child: ListItem(listItems[index]));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ListItem(Subject listItem) {
    return ExpansionTile(
      title: Text(
        listItem.category,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      children: getSubcateogry(listItem.subcategories)
          
      
    );
  }

  
  Widget ExpandItems(SubCategory subcategory){
    return ExpansionTile(
      title: Text(
        subcategory.subcategory,
      ),
      children: <Widget>[
        ListTile(
          title: Text('Videos'),

        ),
        ListTile(
          title: Text('Audio'),

        )
      ],
    );
  }
  
  List<Widget> getSubcateogry(List<SubCategory> subcategories){
    List<Widget> sub = [];
    for (int i=0; i<subcategories.length;i++){
      sub.add(ExpandItems(subcategories[i]));
    }
    return sub;
  }
  
  
  getAPI() async {
    var response = await http
        .get("https://oxystech-study-app-nodejs.herokuapp.com/admin/category");
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);

      print(jsonResponse['result']);
    }
  }
}
