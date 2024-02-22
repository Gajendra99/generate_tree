class TreeNode {
  bool checked;
  bool show;
  int id;
  int pid;
  int commonID;
  String title;
  List<TreeNode> children;

  TreeNode({
    required this.checked,
    required this.show,
    required this.id,
    required this.pid,
    required this.commonID,
    required this.title,
    required this.children,
  });

  factory TreeNode.fromJson(Map<String, dynamic> json) {
    return TreeNode(
      checked: json['checked'] ?? false,
      show: json['show'] ?? false,
      id: json['id'] ?? 0,
      pid: json['pid'] ?? 0,
      commonID: json['commonID'] ?? 0,
      title: json['title'] ?? '',
      children: (json['children'] as List<dynamic>)
          .map((childJson) => TreeNode.fromJson(childJson))
          .toList(),
    );
  }

  List<int> getAllChildrenTitles() {
    List<int> id = [];
    for (var child in children) {
      id.add(child.id);
      id.addAll(child.getAllChildrenTitles());
    }
    return id;
  }
}
