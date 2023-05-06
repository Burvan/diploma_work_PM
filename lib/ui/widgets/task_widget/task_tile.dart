import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:like_button/like_button.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool taskIsDone;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;
  void Function()? onLikePressed;
  final Icon icon;
  TaskTile({
    Key? key,
    required this.taskName,
    required this.taskIsDone,
    required this.icon,
    required this.onLikePressed,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
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
                onPressed: editFunction,
                icon: Icons.edit,
                backgroundColor: Colors.blueGrey,
                borderRadius: BorderRadius.circular(12),
              ),
            ]
        ),
        child: Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.indigo[300]
          //    Colors.blueGrey[400]
          ),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                    children: [
                      Checkbox(value: taskIsDone, onChanged: onChanged),
                      Expanded(
                        child: Text(
                          taskName,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: taskIsDone ? TextDecoration.lineThrough : TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  )
              ),

              IconButton(
                  onPressed: onLikePressed,
                  icon: icon
              ),

            ],
          ),
        ),
      ),
    );
  }
}
