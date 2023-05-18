// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _taskFormKey = GlobalKey<FormState>(),
      _taskNameController = TextEditingController(),
      _taskDescriptionController = TextEditingController(),
      _taskDateController = TextEditingController();
  int countState = 0;

  @override
  Widget build(BuildContext context) {
    final tasks =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?,
        _todoListContainer = tasks?['todoListContainer'],
        _action = tasks?['action'],
        _key = tasks?['key'],
        _title = tasks?['title'],
        _description = tasks?['description'],
        _dueDate = tasks?['dueDate'];

    void addTask(String taskTitle, String taskDescription, dynamic date) {
      _todoListContainer.add({
        "title": taskTitle,
        "description": taskDescription,
        "dueDate": date,
      });
    }

    void editTask(
        dynamic key, String taskTitle, String taskDescription, dynamic date) {
      _todoListContainer.put(_key, {
        'title': taskTitle,
        'description': taskDescription,
        'dueDate': date,
      });
    }

    if (_action == "editTask") {
      _taskNameController.text = _title;
      _taskDescriptionController.text = _description;

      if (countState == 0) {
        _taskDateController.text = _dueDate;
        countState = 1;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Legendary Application"),
        backgroundColor: const Color.fromARGB(255, 12, 31, 41),
        leading: const Icon(
          Icons.storm,
          color: Color.fromARGB(255, 253, 173, 0),
        ),
      ),
      body: Form(
        key: _taskFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin: const EdgeInsets.all(10.0),
              color: const Color.fromARGB(255, 12, 31, 41),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: Text(
                        "To Do List Form",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _taskNameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              prefixIcon: Icon(
                                Icons.task,
                                color: Color.fromARGB(255, 253, 173, 0),
                              ),
                              labelText: 'Task Title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Task Title Is Required.';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _taskDescriptionController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.teal)),
                              prefixIcon: Icon(
                                Icons.book,
                                color: Color.fromARGB(255, 253, 173, 0),
                              ),
                              labelText: 'Task Description',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Task Description Is Required.';
                              }

                              return null;
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                              controller: _taskDateController,
                              decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Color.fromARGB(255, 253, 173, 0),
                                  ),
                                  labelText: "Enter Date"),
                              readOnly: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Date Is Required!';
                                }
                                return null;
                              },
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101));

                                setState(() {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate!);
                                  _taskDateController.text = formattedDate;
                                });
                              }),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor:
                                      const Color.fromARGB(255, 12, 31, 41),
                                ),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_taskFormKey.currentState!.validate()) {
                                    if (_action.toString() == "addTask") {
                                      addTask(
                                          _taskNameController.text,
                                          _taskDescriptionController.text,
                                          _taskDateController.text);
                                    } else {
                                      editTask(
                                          _key,
                                          _taskNameController.text,
                                          _taskDescriptionController.text,
                                          _taskDateController.text);
                                    }

                                    Navigator.of(context).pop();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor:
                                      const Color.fromARGB(255, 12, 31, 41),
                                ),
                                child: const Text(
                                  "Add Task",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
