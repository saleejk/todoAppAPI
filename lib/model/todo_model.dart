class TodoModel {
  String? id;
  String? title;
  String? description;
  TodoModel({required this.title, required this.description, this.id});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
        title: json['title'], description: json['description'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    // data['title'] = title;
    data['title'] = title;
    data['description'] = description;
    data['id'] = id;
    return data;
  }
}
