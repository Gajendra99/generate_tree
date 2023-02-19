import 'package:flutter/material.dart';
import 'package:generate_tree/generate_tree.dart';
import 'package:generate_tree/treeNode.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.lightBlue,
      theme: ThemeData(dividerColor: Colors.transparent),
      home: Scaffold(
        body: SafeArea(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List data = [
      {
        "checked": true,
        "children": [
          {
            "checked": true,
            "show": false,
            "children": [],
            "id": 11,
            "pid": 1,
            "commonID": 1,
            "title": "Child title 11"
          }
        ],
        "id": 1,
        "pid": 0,
        "commonID": 1,
        "show": false,
        "title": "Parent title 1"
      },
      {
        "checked": true,
        "show": false,
        "children": [],
        "id": 2,
        "commonID": 2,
        "pid": 0,
        "title": "Parent title 2"
      },
      {
        "checked": true,
        "children": [
          {
            "checked": true,
            "children": [],
            "id": 31,
            "commonID": 3,
            "pid": 3,
            "show": false,
            "title": "Parent title 3.1"
          },
          {
            "checked": true,
            "children": [
              {
                "checked": true,
                "children": [],
                "id": 311,
                "commonID": 3,
                "pid": 31,
                "show": false,
                "title": "Parent title 3.1.1"
              },
              {
                "checked": true,
                "children": [],
                "id": 312,
                "commonID": 3,
                "pid": 31,
                "show": false,
                "title": "Parent title 3.1.2"
              }
            ],
            "id": 32,
            "commonID": 3,
            "pid": 2,
            "show": false,
            "title": "Parent title 3.2"
          }
        ],
        "id": 3,
        "commonID": 3,
        "pid": 0,
        "show": false,
        "title": "Parent title 3"
      }
    ];

    final List<TreeNode> treeNodes =
    data.map((item) => TreeNode.fromJson(item)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Generate Tree'),
      ),
      body: GenerateTree(
        data: treeNodes,
        selectOneToAll: true,
        textColor: Colors.black,
        onChecked: (node, checked, commonID) {
          print('isChecked : $checked');
          print('common Node ID : ${commonID}');
          print(
              'children node data : ${node.children.map((e) => '${e.title}')}');
        },
        checkBoxColor: Colors.green,
        childrenPadding: EdgeInsets.only(left: 30, top: 0, right: 0, bottom: 0),
      ),
    );
  }
}
