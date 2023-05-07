import 'dart:async';
//import 'package:diplom_work/ui/widgets/habit_widget/new_habit_dialog.dart';
import 'package:diplom_work/domain/data/habits_database.dart';
import 'package:diplom_work/ui/widgets/habit_widget/habit_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'edit_habit_dialog.dart';

class HabitWidget extends StatefulWidget {
  const HabitWidget({Key? key}) : super(key: key);

  @override
  State<HabitWidget> createState() => _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {
  final _habitsBox = Hive.box('habits_box');
  HabitsDatabase db = HabitsDatabase();

  // [habitName, habitStarted, timeSpent, timeGoal]
  final habitController = TextEditingController();
  var editingHabitController = TextEditingController();

  int timeGoal = 1;

  @override
  void initState() {
    if(_habitsBox.get('HABITS') == null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
    super.initState();
  }

  // List habitList = [
  //   ['Swimming', false, 0, 1],
  //   ['Reading', false, 0, 20],
  //   ['Training', false, 0, 1],
  // ];

  void saveNewHabit() {
    final newHabitName = habitController.text;
    if (newHabitName.isEmpty) return;
    setState(() {
      db.habitList.add([newHabitName, false, 0, timeGoal]);
    });
    Navigator.of(context).pop();
    habitController.clear();
    timeGoal = 1;
    db.updateDatabase();
  }

  void saveEditedHabit(int index) {
    final editedHabitName = editingHabitController.text;
    if (editedHabitName.isEmpty) return;
    setState(() {
      db.habitList[index][0] = editedHabitName;
      db.habitList[index][3] = timeGoal;
    });
    Navigator.of(context).pop();
    timeGoal = 1;
    db.updateDatabase();
  }

  void cancel() {
    timeGoal = 1;
    habitController.clear();
    Navigator.of(context).pop();
  }

  void addNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          int intermediateVar = timeGoal;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Adding a new habit'),
              content: Container(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: habitController,
                      maxLines: 3,
                      minLines: 1,
                      //style: TextStyle(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Habit name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (intermediateVar > 1) {
                              setState(() {
                                intermediateVar--;
                                timeGoal = intermediateVar;
                              });
                            }
                          },
                          child: const Text('-1'),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black)),
                          child: Text(
                            '$intermediateVar',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              intermediateVar++;
                              timeGoal = intermediateVar;
                            });
                          },
                          child: const Text('+1'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                            onPressed: cancel, child: const Text('Cancel')),
                        //const SizedBox(width: 5),
                        MaterialButton(
                          onPressed: saveNewHabit,
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void habitStarted(int index) {
    var startTime = DateTime.now();

    int elapsedTime = db.habitList[index][2];
    setState(() {
      db.habitList[index][1] = !db.habitList[index][1];
    });

    if (db.habitList[index][1]) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (!db.habitList[index][1]) {
            timer.cancel();
          }

          var currentTime = DateTime.now();
          db.habitList[index][2] = elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - currentTime.hour);
          if (db.habitList[index][2] == db.habitList[index][3] * 60) {
            timer.cancel();
            db.habitList[index][1] = false;
          }
        });
      });
    }
    db.updateDatabase();
  }

  void settingsOpened(int index) {
    editingHabitController = TextEditingController(text: db.habitList[index][0]);
    showDialog(
        context: context,
        builder: (context) {
          int intermediateVar = db.habitList[index][3];
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Habit editing'),
              content: Container(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: editingHabitController,
                      maxLines: 3,
                      minLines: 1,
                      //style: TextStyle(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Habit name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (intermediateVar > 1) {
                              setState(() {
                                intermediateVar--;
                                timeGoal = intermediateVar;
                              });
                            }
                          },
                          child: const Text('-1'),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                              Border.all(color: Colors.black)),
                          child: Text(
                            '$intermediateVar',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              intermediateVar++;
                              timeGoal = intermediateVar;
                            });
                          },
                          child: const Text('+1'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                            onPressed: cancel, child: const Text('Cancel')),
                        //const SizedBox(width: 5),
                        MaterialButton(
                          onPressed: () => saveEditedHabit(index),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void deleteHabit(int index) {
    setState(() {
      db.habitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: db.habitList.length,
          itemBuilder: (BuildContext context, int habitIndexInList) {
            return HabitTile(
              habitName: db.habitList[habitIndexInList][0],
              onPlayTap: () => habitStarted(habitIndexInList),
              //onSettingsTap: () => settingsOpened(habitIndexInList),
              deleteFunction: (context) => deleteHabit(habitIndexInList),
              editFunction: (context) => settingsOpened(habitIndexInList),
              habitStarted: db.habitList[habitIndexInList][1],
              timeSpent: db.habitList[habitIndexInList][2],
              timeGoal: db.habitList[habitIndexInList][3],
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[300],
        onPressed: addNewHabit,
        child: const Icon(Icons.add),
      ),
    );
  }
}
