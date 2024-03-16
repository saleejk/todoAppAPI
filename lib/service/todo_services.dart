import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/todo_model.dart';

class TodoServices {
  final Dio _dio = Dio();
  final String _url = 'https://65b9ee13b4d53c066551a550.mockapi.io/Todo_App';
  // final String _url = 'https://65f5634df54db27bc02307a6.mockapi.io/todolist';
  Future<List<TodoModel>> fetchTodo() async {
    try {
      final Response response = await _dio.get(_url);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => TodoModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load Todo');
      }
    } catch (error) {
      throw Exception('Failed to load Todo data : $error');
    }
  }

  Future<void> addTodo(TodoModel value) async {
    try {
      await _dio.post(_url, data: value.toJson());
    } catch (error) {
      throw Exception('Error on adding Todo :$error');
    }
  }

  Future<void> updateTodo(TodoModel value, String id) async {
    try {
      await _dio.put('$_url/$id', data: value.toJson());
    } catch (error) {
      throw Exception('error on updating Todo :$error');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _dio.delete('$_url/$id');
    } catch (error) {
      throw Exception('Error while deleting todo: $error');
    }
  }
}
