import 'package:diplom_work/ui/widgets/expense_widget/bar_graph/bar_graph.dart';
import 'package:diplom_work/ui/widgets/expense_widget/date_time/date_time_helper.dart';
import 'package:diplom_work/ui/widgets/expense_widget/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../domain/data/expenses_database.dart';
import 'expenses_widget.dart';

class ExpenseSummary extends StatelessWidget {
  final _expensesBox = Hive.box('tasks_box');
  ExpenseDatabase db = ExpenseDatabase();
  final DateTime startOfWeek;
  ExpenseSummary({required this.startOfWeek, Key? key}) : super(key: key);

  double calculateMax(
      ExpenseData value,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      String sunday) {
    double? max = 100;
    List<double> values = [
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
    ];

    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  double calculateWeekTotal(
      ExpenseData value,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      String sunday) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {

    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 15),
                  child: Row(
                    children: [
                      const Text(
                        'Weekly total:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${calculateWeekTotal(value, monday, tuesday, wednesday,
                            thursday, friday, saturday, sunday)} BYN',
                        style: TextStyle(fontSize: 18, color: calculateWeekTotal(value, monday, tuesday, wednesday,
                            thursday, friday, saturday, sunday) > globalExpenseLimit ? Colors.red : Colors.green),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: MyBarGraph(
                    maxY: calculateMax(value, monday, tuesday, wednesday,
                        thursday, friday, saturday, sunday),
                    monAmount:
                        value.calculateDailyExpenseSummary()[monday] ?? 0,
                    tueAmount:
                        value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                    wedAmount:
                        value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                    thurAmount:
                        value.calculateDailyExpenseSummary()[thursday] ?? 0,
                    friAmount:
                        value.calculateDailyExpenseSummary()[friday] ?? 0,
                    satAmount:
                        value.calculateDailyExpenseSummary()[saturday] ?? 0,
                    sunAmount:
                        value.calculateDailyExpenseSummary()[sunday] ?? 0,
                  ),
                ),
              ],
            ));
  }
}
