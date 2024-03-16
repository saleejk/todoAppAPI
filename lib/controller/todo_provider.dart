import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter_application_1/model/todo_model.dart';
import 'package:flutter_application_1/service/todo_services.dart';

class TodoProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
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
      notifyListeners();
    } catch (error) {
      log('error On fetching Todo : $error');
      rethrow;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo() async {
    try {
      await todoservices.addTodo(TodoModel(
          title: titleAddController.text,
          description: descriptionAddController.text));
      notifyListeners();
      titleAddController.clear();
      descriptionAddController.clear();
      await fetchTodo();
    } catch (error) {
      log('Error got while adding todo :$error');
    }
  }

  Future<void> updateTodo(title, description, String id) async {
    try {
      await todoservices.updateTodo(
          TodoModel(title: title, description: description), id);
      await fetchTodo();
    } catch (error) {
      log('Error while updating: $error');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await todoservices.deleteTodo(id);
      await fetchTodo();
      notifyListeners();
    } catch (error) {
      log('Error while deleting todo :$error');
      rethrow;
    }
  }
}
