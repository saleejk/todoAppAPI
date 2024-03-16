import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/todo_provider.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO APP',
        theme: ThemeData.dark(),
        home: const HomeScreen(),
      ),
    );
  }
}
