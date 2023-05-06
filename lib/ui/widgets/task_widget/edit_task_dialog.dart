import 'package:flutter/material.dart';

class EditTaskDialog extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  EditTaskDialog({Key? key, required this.controller, required this.onCancel, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Task editing'),
      //backgroundColor: Colors.grey,
      content: Container(
        height: 130,
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
                labelText: 'Add a new task',
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