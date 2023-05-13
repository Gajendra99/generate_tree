import 'package:flutter/material.dart';

import '../treeNode.dart';

class GenerateTree extends StatefulWidget {
  final List<TreeNode> data;
  final bool selectOneToAll;
  final Function(TreeNode node, bool checked, int commonId) onChecked;
  Color? textColor;
  Color? checkBoxColor;
  EdgeInsets? childrenPadding;

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
              _toggleNodeSelection(node);
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

  void _toggleNodeSelection(TreeNode node) {
    node.checked = !node.checked;
    for (var child in node.children) {
      // child.checked = node.checked;
      _toggleNodeSelection(child);
    }
  }
}
