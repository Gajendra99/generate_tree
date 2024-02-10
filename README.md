with generate_tree you can create a tree structure with checkbox option inside your app. It needs less code,
you just need a List map to create this tree.

## Usage

To use this package, add <b>generate_tree</b> as a dependency in your pubspec.yaml file.

<BR>
<Table>
    <tr>
        <td><img src="https://ik.imagekit.io/gajendramenaria9/gif1.gif?ik-sdk-version=javascript-1.4.3&updatedAt=1676791685679" alt="preview2"/></td>
<td><img src="https://ik.imagekit.io/gajendramenaria9/gif2.gif?ik-sdk-version=javascript-1.4.3&updatedAt=1676791681599" alt="preview"/></td>
    </tr>
</Table>

## Features

<ul>
<li><b>Single tick checkbox</b>
<ul>
    <li>set 'selectOneToAll' property 'false' to select only one at a time</li>
</ul>
</li>
<li><b>Multi select checkbox</b>
<ul>
<li>set 'selectOneToAll' property 'true' to select all children</li>
<li>get all node details in onChecked()</li>
</ul>
</li>
<li><b>change the colors of checkbox</b></li>
<li><b>change the colors of text</b></li>
<li><b>onChecked function provides the value</b>
<ul>
<li><b>node:</b> all child values and current selected node values</li>
<li><b>checked:</b> provides the bool value that the checkbox is checked or not</li>
<li><b>commonID:</b> returns the common id when selectOneToAll is true</li>
</ul>
</li>
</ul>

## Getting started

Follow this steps to use this package

## Install

```html
generate_tree: ^2.1.0
```

## Import package

```dart
import 'generate_tree/generate_tree.dart';
```

first you will need a data list:

```dart
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
```

then pass the data to TreeNode.fromJson() to get the List<TreeNode>

```dart
final List<TreeNode> treeNodes =
        data.map((item) => TreeNode.fromJson(item)).toList();
```

Now pass this treeNodes to GenerateTree(data: treeNodes) to generate the tree

```dart
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Generate Tree'),
    ),
    body: GenerateTree(
      data: treeNodes,
      selectOneToAll: false,
      textColor: Colors.blue,
      onChecked: (node, checked, commonID) {
        print('isChecked : $checked');
        print('common Node ID : ${commonID}');
        print(
            'children node data : ${node.children.map((e) => '${e.title}')}');
      },
      checkBoxColor: Colors.blue,
      childrenPadding: EdgeInsets.only(left: 40, top: 0, right: 0, bottom: 0),
    ),
  );
}
```

## Developer

<H3>Gajendra Somawat</H3>
<p>Instagram: <a href="https://www.instagram.com/gajendra_menaria9">gajendra_menaria9</a></p>

## Additional Details

for more details visit example page or contact on <a href="https://www.instagram.com/gajendra_menaria9">Instagram</a>
