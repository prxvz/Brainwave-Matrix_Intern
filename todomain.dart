import 'package:flutter/material.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My task1-ToDo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 227, 9, 82)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const TodoListScreen(),
    );
    
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<TodoItem> _todoItems = [];

  final TextEditingController _textFieldController = TextEditingController();

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(task));
      });
      _textFieldController.clear();
    }
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].toggleDone();
    });
  }

  Widget _buildTodoItem(TodoItem todoItem, int index) {
    return ListTile(
      title: Text(
        todoItem.task,
        style: TextStyle(
          decoration:  todoItem.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        value: todoItem.isDone,
        onChanged: (_) => _toggleTodoItem(index),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _removeTodoItem(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("To-Do"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(
                hintText: 'Enter a task',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addTodoItem(_textFieldController.text),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                return _buildTodoItem(_todoItems[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  final String task;
  bool isDone;

  TodoItem(this.task, {this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}