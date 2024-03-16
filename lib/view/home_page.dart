import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/todo_provider.dart';
import 'package:flutter_application_1/view/add_data.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TodoProvider>(context, listen: false).fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 2, 82),
        title: const Text(
          'Todo List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Consumer<TodoProvider>(builder: (context, pro, child) {
            return pro.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : pro.todoList.isEmpty
                    ? Center(
                        child: Lottie.asset(
                            'assets/Animation - empty list.json',
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.7),
                      )
                    : ListView.builder(
                        itemCount: pro.todoList.length,
                        itemBuilder: (ctx, index) {
                          final data = pro.todoList.length - index - 1;
                          final todo = pro.todoList[data];
                          return Card(
                            child: ListTile(
                              leading:
                                  CircleAvatar(child: Text('${index + 1}')),
                              title: Text(todo.title.toString()),
                              subtitle: Text(
                                todo.description.toString(),
                              ),
                              trailing: PopupMenuButton(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    updateAlertBox(
                                        context,
                                        todo.id,
                                        todo.title.toString(),
                                        todo.description.toString());
                                  } else if (value == 'delete') {
                                    Provider.of<TodoProvider>(context,
                                            listen: false)
                                        .deleteTodo(todo.id.toString());
                                  }
                                },
                                itemBuilder: (context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('edit'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('delete'),
                                    )
                                  ];
                                },
                              ),
                            ),
                          );
                        },
                      );
          }))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 39, 2, 82),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return const AddScreen();
          }));
        },
        label: const Text(
          'ADD TODO',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  updateAlertBox(context, id, String title, String description) {
    final editFormkey = GlobalKey<FormState>();
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController descriptionController =
        TextEditingController(text: description);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('EDIT TODO'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Form(
                key: editFormkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter text";
                        } else {
                          return null;
                        }
                      },
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter text";
                        } else {
                          return null;
                        }
                      },
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        String newTitle = titleController.text.trim();
                        String newDescription =
                            descriptionController.text.trim();
                        Provider.of<TodoProvider>(context, listen: false)
                            .updateTodo(newTitle, newDescription, id);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.update),
                      label: const Text('Update'),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
