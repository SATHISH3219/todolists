import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  final String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primaryColor: Color(0xFF4CAF50), // Green primary color
        primaryColorLight: Color(0xFFFFC107), // Yellow accent color
        scaffoldBackgroundColor: Color(0xFFE0E0E0), // Light grey background
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Task> tasks = [];
  TextEditingController _textController = TextEditingController();

  void _addTask(String taskName) {
    // Check if the taskName is unique before adding
    if (tasks.every((task) => task.name != taskName)) {
      setState(() {
        tasks.add(Task(name: taskName));
        _textController.clear();
      });
    } else {
      // Display a message or handle the case where the name is not unique
      print('Task with the same name already exists.');
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _deleteCompletedTasks() {
    setState(() {
      tasks.removeWhere((task) => task.isCompleted);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo List',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Text(
                      task.name,
                      style: TextStyle(
                        color: task.isCompleted ? Colors.grey : Colors.black,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Checkbox(
                      value: task.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          task.isCompleted = value ?? false;
                        });
                      },
                    ),
                    onLongPress: () {
                      _deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: (taskName) {
                      _addTask(taskName);
                    },
                    style: TextStyle(
                      color: const Color.fromARGB(
                          255, 0, 0, 0), // Text color for the TextField
                    ),
                    cursorColor: Colors.white, // Cursor color for the TextField
                    decoration: InputDecoration(
                      hintText: 'Enter task',
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(
                            179, 0, 0, 0), // Hint text color
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(
                          125, 117, 117, 117), // Dark blue background color
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_box_rounded),
                  onPressed: () {
                    _addTask(_textController.text);
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _deleteCompletedTasks,
            child: Text('Delete Completed'),
          ),
        ],
      ),
    );
  }
}
