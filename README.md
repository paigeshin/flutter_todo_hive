### Packages

https://www.youtube.com/watch?v=mMgr47QBZWA&list=PLKgMkFDoSSsUUdcLgIO4TjmP3k6s4aUqq&index=16&t=21s

```shell
flutter pub add hive
flutter pub add hive_flutter
flutter pub add -d hive_generator
flutter pub add -d build_runner
```

### Basic Usage

```dart
  // init the hive
  await Hive.initFlutter();

  // open a box
  final _ = await Hive.openBox('box');

  runApp(const MyApp());
```

```dart
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

```
