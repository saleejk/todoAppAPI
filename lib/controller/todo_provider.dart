import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/model/todo_model.dart';
import 'package:flutter_application_1/service/todo_services.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController titleAddController = TextEditingController();
  TextEditingController descriptionAddController = TextEditingController();
  TodoServices todoservices = TodoServices();
  List<TodoModel> todoList = [];
  bool isLoading = false;
  Future<void> fetchTodo() async {
    isLoading = true;
    notifyListeners();
    try {
      todoList = await todoservices.fetchTodo();
    } catch (e) {}
    {}
  }
}
