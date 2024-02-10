// import 'package:flutter/material.dart';

// import '../treeNode.dart';
// import 'package:collection/collection.dart';

// class GenerateTree extends StatefulWidget {
//   final List<TreeNode> data;
//   final bool selectOneToAll;
//   final Function(TreeNode node, bool checked, int commonId) onChecked;
//   final Color? textColor;
//   final Color? checkBoxColor;
//   final EdgeInsets? childrenPadding;

//   GenerateTree(
//       {this.checkBoxColor,
//       this.textColor,
//       this.childrenPadding,
//       required this.onChecked,
//       required this.data,
//       required this.selectOneToAll});

//   @override
//   _GenerateTree createState() => _GenerateTree();
// }

// class _GenerateTree extends State<GenerateTree> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   Map<String, int> map = {};
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemBuilder: (BuildContext context, int index) {
//         return _buildNode(widget.data[index], EdgeInsets.all(0));
//       },
//       itemCount: widget.data.length,
//     );
//   }

//   Widget _buildNode(TreeNode node, EdgeInsets childrenPadding) {
//     var nonCheckedIcon = Icon(
//       Icons.check_box_outline_blank,
//       color: widget.checkBoxColor ?? Colors.green,
//     );
//     var checkedIcon = Icon(
//       Icons.check_box,
//       color: widget.checkBoxColor ?? Colors.green,
//     );

//     return Padding(
//       padding: childrenPadding,
//       child: ExpansionTile(
//         iconColor: widget.checkBoxColor,
//         collapsedIconColor: widget.checkBoxColor,
//         tilePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//         initiallyExpanded: node.show,
//         title: Container(
//           margin: EdgeInsets.only(left: 0),
//           padding: EdgeInsets.only(left: 0),
//           child: Text(
//             node.title,
//             style: TextStyle(color: widget.textColor ?? Colors.black),
//           ),
//         ),
//         leading: IconButton(
//           icon: node.checked ? checkedIcon : nonCheckedIcon,
//           onPressed: () {
//             setState(() {
//               _toggleNodeSelection(node, !node.checked);
//               widget.onChecked(node, node.checked, node.id);
//             });
//           },
//         ),
//         children: node.children
//             .map((child) =>
//                 _buildNode(child, widget.childrenPadding ?? EdgeInsets.all(0)))
//             .toList(),
//       ),
//     );
//   }

//   void _toggleNodeSelection(TreeNode node, bool isChecked) {
//     node.checked = isChecked;
//     _updateParentNodes(node, isChecked);
//     for (var child in node.children) {
//       _toggleNodeSelection(child, isChecked);
//     }
//   }

//   void _updateParentNodes(TreeNode node, bool checked) {
//     if (checked) {
//       if (node.pid != 0) {
//         final parentNode =
//             widget.data.firstWhereOrNull((n) => n.id == node.pid);

//         if (parentNode != null) {
//           parentNode.checked =
//               parentNode.children.any((child) => child.checked);

//           _updateParentNodes(parentNode, checked);
//         }
//       }
//     } else {
//       if (node.pid != 0) {
//         //first check all childrens are not selected then change parent from checked to non-checked
//         final parentNode =
//             widget.data.firstWhereOrNull((n) => n.id == node.pid);

//         if (parentNode != null) {
//           parentNode.checked =
//               parentNode.children.any((child) => child.checked);

//           _updateParentNodes(parentNode, checked);
//         }
//       }
//     }
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';

import '../treeNode.dart';
import 'package:collection/collection.dart';

class GenerateTree extends StatefulWidget {
  final List<TreeNode> data;
  final bool selectOneToAll;
  final Function(TreeNode node, bool checked, int commonId) onChecked;
  final Color? textColor;
  final Color? checkBoxColor;
  final EdgeInsets? childrenPadding;

  GenerateTree(
      {this.checkBoxColor,
      this.textColor,
      this.childrenPadding,
      required this.onChecked,
      required this.data,
      required this.selectOneToAll});

  @override
  _GenerateTree createState() => _GenerateTree();
}

class _GenerateTree extends State<GenerateTree> {
  @override
  void initState() {
    super.initState();
  }

  Map<String, int> map = {};
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildNode(widget.data[index], EdgeInsets.all(0));
      },
      itemCount: widget.data.length,
    );
  }

  Widget _buildNode(TreeNode node, EdgeInsets childrenPadding) {
    var nonCheckedIcon = Icon(
      Icons.check_box_outline_blank,
      color: widget.checkBoxColor ?? Colors.green,
    );
    var checkedIcon = Icon(
      Icons.check_box,
      color: widget.checkBoxColor ?? Colors.green,
    );

    return Padding(
      padding: childrenPadding,
      child: ExpansionTile(
        iconColor: widget.checkBoxColor,
        collapsedIconColor: widget.checkBoxColor,
        tilePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        initiallyExpanded: node.show,
        title: Container(
          margin: EdgeInsets.only(left: 0),
          padding: EdgeInsets.only(left: 0),
          child: Text(
            node.title,
            style: TextStyle(color: widget.textColor ?? Colors.black),
          ),
        ),
        leading: IconButton(
          icon: node.checked ? checkedIcon : nonCheckedIcon,
          onPressed: () {
            setState(() {
              _toggleNodeSelection(node, !node.checked);
              widget.onChecked(node, node.checked, node.id);
            });
          },
        ),
        children: node.children
            .map((child) =>
                _buildNode(child, widget.childrenPadding ?? EdgeInsets.all(0)))
            .toList(),
      ),
    );
  }

  void _toggleNodeSelection(TreeNode node, bool isChecked) {
    node.checked = isChecked;
    _updateParentNodes(node, isChecked);
    for (var child in node.children) {
      _toggleNodeSelection(child, isChecked);
    }
  }

  void _updateParentNodes(TreeNode node, bool checked) {
    //First Check it has parent node
    bool canContinue = false;
    if (node.pid != 0) {
      canContinue = true;
    }

    //if it have parent node then check all childrens are checked or non checked
    bool canCheck = true;
    for (int i = 0; i < node.children.length; i++) {
      if (node.children[i].checked != checked) {
        canCheck = false;
      }
    }

    if (canCheck) {
      node.checked = checked;
    }

    if (canContinue) {
      checkEachNode(widget.data, node, checked);
    }
    // if all childrens are non checked the check parent node in widget.node if it matches node id then check above parent node
  }

  checkEachNode(List<TreeNode> checkNode, TreeNode node, bool checked) {
    bool canStop = false;
    for (int i = 0; i < checkNode.length; i++) {
      if (checkNode[i].children.isNotEmpty) {
        checkEachNode(checkNode[i].children, node, checked);
      }
      if (checkNode[i].id == node.pid && !canStop) {
        canStop = true;
        _updateParentNodes(checkNode[i], checked);
        break;
      }
    }
  }
}
