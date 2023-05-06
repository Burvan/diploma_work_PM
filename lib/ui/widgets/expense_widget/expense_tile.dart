import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'date_time/date_time_helper.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  Function(BuildContext)? deleteFunction;
  ExpenseTile({
    Key? key,
    required this.deleteFunction,
    required this.name,
    required this.amount,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete_outline,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(convertDateTimeToStringWithDivider(dateTime)),
        // subtitle: Text('${dateTime.day} / ${dateTime.month} / ${dateTime.year}'),
        trailing: Text('${amount} BYN'),
      ),
    );
    ;
  }
}
