import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Map<String, dynamic>> _todoList = [];
  final _todoListContainer = Hive.box('todoList');

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() {
    final data = _todoListContainer.keys.map((key) {
      final value = _todoListContainer.get(key);
      return {
        "key": key,
        "title": value?["title"],
        "description": value?['description'],
        "dueDate": value?['dueDate'],
      };
    }).toList();

    setState(() {
      _todoList = data.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Legendary Application"),
        backgroundColor: const Color.fromARGB(255, 12, 31, 41),
        leading: const Icon(
          Icons.storm,
          color: Color.fromARGB(255, 253, 173, 0),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.door_back_door, color: Color.fromARGB(255, 253, 173, 0),),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
      ),
      body: _todoList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage("img/image.png"),
                    width: 190,
                  ),
                  Text(
                    '#No More Task, Feel Free',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (_, index) {
                final currentTask = _todoList[index];
                return Dismissible(
                    key: Key(currentTask['key'].toString()),
                    onDismissed: (_) {
                      _todoListContainer.delete(currentTask['key']);
                      _refreshList();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 12, 31, 41)),
                            ),
                            onPressed: () async {
                              await Navigator.pushNamed(
                                context,
                                '/editTask',
                                arguments: {
                                  "todoListContainer": _todoListContainer,
                                  "action": "editTask",
                                  "key": currentTask['key'],
                                  "title": currentTask['title'],
                                  "description": currentTask['description'],
                                  "dueDate": currentTask['dueDate'],
                                },
                              );

                              _refreshList();
                            },
                            child: ListTile(
                              title: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsetsDirectional
                                            .symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.paste,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              currentTask['title']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 194, 194, 194),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    currentTask['description'].toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Due Date : ",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    currentTask['dueDate'].toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(204, 253, 173, 0),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ));
              },
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        onPressed: () async => {
          await Navigator.pushNamed(context, '/addTask', arguments: {
            "todoListContainer": _todoListContainer,
            "action": "addTask",
            "key": null,
            "title": null,
            "currentTask": null,
            "dueDate": null,
          }),
          _refreshList()
        },
        backgroundColor: const Color.fromARGB(255, 12, 31, 41),
        child: const Icon(
          Icons.task,
          color: Color.fromARGB(255, 253, 173, 0),
        ),
      ),
    );
  }
}
