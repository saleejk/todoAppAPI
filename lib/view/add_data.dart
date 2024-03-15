import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/todo_provider.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 2, 82),
        title: const Text('ADD TODO',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: todoProvider.titleAddController,
              decoration: InputDecoration(),
            ),
            TextFormField(
              controller: todoProvider.descriptionAddController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 15,
            ),
            TextButton(onPressed: () {}, child: Text('Submit')),
          ],
        ),
      ),
    );
  }
}
