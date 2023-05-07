import 'package:diplom_work/domain/data/tasks_database.dart';
import 'package:diplom_work/ui/widgets/task_widget/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'edit_task_dialog.dart';
import 'new_task_dialog.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final _tasksBox = Hive.box('tasks_box');
  TasksDatabase db = TasksDatabase();

  @override
  void initState() {
    if(_tasksBox.get('TASKS') == null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
    super.initState();
  }

  bool isFavourite = false;
  final taskController = TextEditingController();
  var editedTaskController = TextEditingController();
  // List tasks = [
  //   ['fggfg', false, false],
  //   ['fggfg', true, true],
  // ];

  void saveNewTask() async{
    final newTaskName = taskController.text;
    if (newTaskName.isEmpty) return;

    setState(() {
      db.tasks.add([newTaskName, false, false]);
    });
    Navigator.of(context).pop();
    taskController.clear();
    db.updateDatabase();
  }

  void saveEditedTask(int index) {
    final editedTaskName = editedTaskController.text;
    setState(() {
      db.tasks[index][0] = editedTaskName;
    });
    Navigator.of(context).pop();
    editedTaskController.clear();
    db.updateDatabase();
  }

  void cancel(){
    taskController.clear();
    Navigator.of(context).pop();
  }

  void addNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return NewTaskDialog(
            controller: taskController,
            onCancel: cancel,
            onSave: saveNewTask,
          );
        });
  }

  void deleteTask(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    db.updateDatabase();
  }

  editTask(int index) {
    editedTaskController = TextEditingController(text: db.tasks[index][0]);
    showDialog(
        context: context,
        builder: (context) {
          return EditTaskDialog(
            controller: editedTaskController,
            onCancel: () => Navigator.of(context).pop(),
            onSave: () => saveEditedTask(index),
          );
        });
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.tasks[index][1] = !db.tasks[index][1];
    });
    db.updateDatabase();
  }

  void onLikePressed(int index, bool? value) {
    setState(() {
      db.tasks[index][2] = !db.tasks[index][2];
    });
    db.updateDatabase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: db.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return TaskTile(
            taskName: db.tasks[index][0],
            taskIsDone: db.tasks[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            editFunction: (context) => editTask(index),
            icon: db.tasks[index][2]
                ? const Icon(Icons.favorite, color: Colors.red,)
                : const Icon(Icons.favorite_outline),
            onLikePressed: () => onLikePressed(index, db.tasks[index][2]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[300],
        onPressed: addNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
