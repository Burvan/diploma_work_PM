import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onPlayTap;
  final VoidCallback onSettingsTap;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;
  Function(BuildContext)? deleteFunction;
  HabitTile({
    Key? key,
    required this.habitName,
    required this.onPlayTap,
    required this.onSettingsTap,
    required this.timeSpent,
    required this.timeGoal,
    required this.habitStarted,
    required this.deleteFunction
  }) : super(key: key);

  //method which converting seconds to minutes : 65 sec = 1.05 min
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(5);

    if (secs.length == 1) {
      secs = '0$secs';
    }
    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }
    return '$mins:$secs';
  }

  double percentCompleted() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Slidable(
        endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete_outline,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              SlidableAction(
                onPressed: (context){},
                icon: Icons.edit,
                backgroundColor: Colors.blueGrey,
                borderRadius: BorderRadius.circular(12),
              ),
            ]
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.indigo[300],
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onPlayTap,
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      // color: Colors.green,
                      child: Stack(
                        children: [
                          Center(
                            child: CircularPercentIndicator(
                              radius: 30,
                              percent: percentCompleted() < 1 ? percentCompleted() : 1,
                              progressColor: percentCompleted() <= 0.5
                                  ? Colors.red
                                  : (percentCompleted() <= 0.75
                                      ? Colors.orange
                                      : (percentCompleted() < 1
                                          ? Colors.lightGreen
                                          : Colors.green)),
                            ),
                          ),
                          Center(
                            child: habitStarted
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habitName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      timeSpent < timeGoal * 60 ?
                      Text(
                        '${formatToMinSec(timeSpent)} / $timeGoal.00 = ${(percentCompleted() * 100).toStringAsFixed(0)}%',
                        // '$timeSpent / $timeGoal',
                        style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                      ) : Text(
                        '$timeGoal.00 / $timeGoal.00 = ${(percentCompleted() * 100).toStringAsFixed(0)}%',
                        // '$timeSpent / $timeGoal',
                        style: TextStyle(fontSize: 15, color: Colors.grey[400]),
                      )
                    ],
                  ),
                ],
              ),
              IconButton(
                  onPressed: onSettingsTap, icon: const Icon(Icons.settings)),
            ],
          ),
        ),
      ),
    );
  }
}
