import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/dialog_box.dart';
import 'package:todo_app/todo_database.dart';
import 'package:todo_app/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _box = Hive.box('box');
  final TodoDatabase _todoDB = TodoDatabase();

  final _controller = TextEditingController();

  @override
  void initState() {
    if (_box.get('TODOLIST') == null) {
      _todoDB.createInitialData();
    } else {
      _todoDB.load();
    }
    super.initState();
  }

  void _saveNewTask() {
    setState(() {
      _todoDB.todoList.add([_controller.text, false]);
    });
    _todoDB.update();
    Navigator.of(context).pop();
    _controller.clear();
  }

  void _checkBoxChanged(bool? value, int index) {
    setState(() {
      _todoDB.todoList[index][1] = value;
    });
    _todoDB.update();
  }

  void _createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: _saveNewTask,
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      _todoDB.todoList.removeAt(index);
    });
    _todoDB.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: const Text('TO DO'),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _createNewTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: _todoDB.todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: _todoDB.todoList[index][0],
              taskCompleted: _todoDB.todoList[index][1],
              onChanged: (value) => _checkBoxChanged(value, index),
              onDelete: (_) => _deleteTask(index),
            );
          },
        )

        // ListView(
        //   children: [
        //     TodoTile(
        //       taskName: 'Make Tutorial',
        //       taskCompleted: true,
        //       onChanged: (finished) {},
        //     ),
        //     TodoTile(
        //       taskName: 'Do Excercise',
        //       taskCompleted: false,
        //       onChanged: (finished) {},
        //     ),
        //   ],
        // ),
        );
  }
}
