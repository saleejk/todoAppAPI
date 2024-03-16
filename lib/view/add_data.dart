import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/todo_provider.dart';
import 'package:flutter_application_1/view/home_page.dart';
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
        backgroundColor: const Color.fromARGB(255, 39, 2, 82),
        title: const Text('ADD TODO',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Form(
          key: todoProvider.formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Text";
                  } else {
                    return null;
                  }
                },
                controller: todoProvider.titleAddController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Text";
                  } else {
                    return null;
                  }
                },
                controller: todoProvider.descriptionAddController,
                decoration: const InputDecoration(hintText: 'Description'),
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 15,
              ),
              TextButton(
                  onPressed: () {
                    if (todoProvider.formKey.currentState!.validate()) {
                      todoProvider.addTodo();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const HomeScreen();
                      }));
                    }
                  },
                  child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
