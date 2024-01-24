import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



import 'firebase_options.dart'; // Import the file with Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Default options
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      home: TodoPage(),
    );
  }
}

// ... (Rest of the code remains unchanged)


class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final DatabaseReference _todoReference =
  FirebaseDatabase.instance.reference().child('todos');

  List<String> todos = [];
  TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    _todoReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>?;
        todos = values?.values.cast<String>().toList() ?? [];
      } else {
        todos = [];
      }
      setState(() {});
    });
  }


  Future<void> _addTodo() async {
    String newTodo = _todoController.text.trim();
    if (newTodo.isNotEmpty) {
      _todoController.clear();
      await _todoReference.push().set(newTodo);
      _loadTodos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(todos[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Enter your to-do',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
