import 'package:flutter/material.dart';

class NewTaskDialog extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  NewTaskDialog({Key? key, required this.controller, required this.onCancel, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adding a new task'),
      content: Container(
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              maxLines: 3,
              minLines: 1,
              //style: TextStyle(),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task name',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: onCancel,
                    child: const Text('Cancel')
                ),
                const SizedBox(width: 5),
                ElevatedButton(onPressed: onSave, child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
