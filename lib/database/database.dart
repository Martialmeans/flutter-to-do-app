import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List toDoList = [];

  // reference our box
  final _mybox = Hive.box('hive_box');

  // run this method if its the first-time ever opening the app
  void createInitialData() {
    toDoList = [
      ["Write your tasks", false],
      ["they should appear here", false]
    ];
  }

  // load the data from the database
  void loadDatabase() {
    toDoList = _mybox.get("TODOLIST");
  }

  // update the database
  void updateDatabase() {
    _mybox.put("TODOLIST", toDoList);
  }
}
