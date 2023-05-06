import 'dart:async';
//import 'package:diplom_work/ui/widgets/habit_widget/new_habit_dialog.dart';
import 'package:diplom_work/ui/widgets/habit_widget/habit_tile.dart';
import 'package:flutter/material.dart';
import 'edit_habit_dialog.dart';

class HabitWidget extends StatefulWidget {
  const HabitWidget({Key? key}) : super(key: key);

  @override
  State<HabitWidget> createState() => _HabitWidgetState();
}

class _HabitWidgetState extends State<HabitWidget> {
  // [habitName, habitStarted, timeSpent, timeGoal]
  final habitController = TextEditingController();
  int timeGoal = 1;
  List habitList = [
    ['Swimming', false, 0, 1],
    ['Reading', false, 0, 20],
    ['Training', false, 0, 1],
  ];

  void incrementTimeGoal(){
    setState(() {
      timeGoal++;
    });
  }

  void decrementTimeGoal(){
    if(timeGoal > 1){
      setState(() {
        timeGoal--;
      });
    }
  }

  void saveNewHabit(){
    final newHabitName = habitController.text;
    if(newHabitName.isEmpty) return;
    setState(() {
      habitList.add([newHabitName, false, 0, timeGoal]);
    });
    Navigator.of(context).pop();
    habitController.clear();
    timeGoal = 1;
  }



  void addNewHabit(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text('Adding a new habit'),
        content: Container(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
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
                      onPressed: decrementTimeGoal,
                      child: const Text('-1')
                  ),
                  Text('$timeGoal'),
                  ElevatedButton(
                      onPressed: incrementTimeGoal,
                      child: const Text('+1')
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                      onPressed: ()=>Navigator.of(context).pop(),
                      child: const Text('Cancel')
                  ),
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
  }



  void habitStarted(int index) {
    var startTime = DateTime.now();

    int elapsedTime = habitList[index][2];
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });

    if (habitList[index][1]) {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (!habitList[index][1]) {
            timer.cancel();
          }

          var currentTime = DateTime.now();
          habitList[index][2] = elapsedTime +
              currentTime.second -
              startTime.second +
              60 * (currentTime.minute - startTime.minute) +
              60 * 60 * (currentTime.hour - currentTime.hour);
          if (habitList[index][2] == habitList[index][3] * 60) {
            timer.cancel();
            habitList[index][1] = false;
          }
        });
      });
    }
  }

  void settingsOpened(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return const EditHabitDialog();
        });
  }

  void deleteHabit (int index){
    setState(() {
      habitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: habitList.length,
            itemBuilder: (BuildContext context, int habitIndexInList) {
              return HabitTile(
                habitName: habitList[habitIndexInList][0],
                onPlayTap: () => habitStarted(habitIndexInList),
                onSettingsTap: () => settingsOpened(habitIndexInList),
                deleteFunction: (context)=>deleteHabit(habitIndexInList),
                habitStarted: habitList[habitIndexInList][1],
                timeSpent: habitList[habitIndexInList][2],
                timeGoal: habitList[habitIndexInList][3],
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
