import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];

  // Reference our box
  final _box = Hive.box('box');

  // Run thid method if this is the 1st time ever opening this app
  void createInitialData() {
    todoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false],
    ];
  }

  // load the data from database
  void load() {
    todoList = _box.get('TODOLIST');
  }

  // update the database
  void update() {
    _box.put('TODOLIST', todoList);
  }
}
