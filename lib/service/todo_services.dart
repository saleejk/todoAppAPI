import 'package:dio/dio.dart';
import 'package:flutter_application_1/controller/model/todo_model.dart';

class TodoServices {
  final Dio _dio = Dio();
  final String _url='https://65b9ee13b4d53c066551a550.mockapi.io/Todo_App';
Future<List<TodoModel>> fetchTodo()async{try {final Response responce=await _dio.get(_url);if(responce.statusCode==200){return(responce.statusCode==200){return(responce.data as List).map((json) => TodoModel.fromJson(json)).toList();}else{throw Exception('failed to load Todo');}
  
} catch (error) {throw Exception('failed to load todo')
  

}}}}
 