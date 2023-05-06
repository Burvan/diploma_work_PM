import 'package:hive_flutter/hive_flutter.dart';

class TasksDatabase {
  List tasks = [];
  final _tasksBox = Hive.box('tasks_box');

  void createInitialData(){
    tasks = [
      ['Write my first task', false, false],
    ];
  }

  void loadData(){
    tasks = _tasksBox.get('TASKS');
  }

  void updateDatabase(){
    _tasksBox.put('TASKS', tasks);
  }

}