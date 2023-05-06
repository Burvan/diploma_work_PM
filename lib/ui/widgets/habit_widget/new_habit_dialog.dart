import 'package:flutter/material.dart';

class NewHabitDialog extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  VoidCallback increment;
  VoidCallback decrement;
  int timeGoal;
  NewHabitDialog({
    Key? key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
    required this.increment,
    required this.decrement,
    required this.timeGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adding a new habit'),
      content: Container(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
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
                    onPressed: decrement,
                    child: const Text('-1')
                ),
                Text('$timeGoal'),
                ElevatedButton(
                    onPressed: increment,
                    child: const Text('+1')
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                    onPressed: onCancel,
                    child: const Text('Cancel')
                ),
                //const SizedBox(width: 5),
                MaterialButton(onPressed: onSave, child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
