import 'package:diplom_work/domain/data/expenses_database.dart';
import 'package:diplom_work/ui/widgets/expense_widget/expense_data.dart';
import 'package:diplom_work/ui/widgets/expense_widget/expense_item.dart';
import 'package:diplom_work/ui/widgets/expense_widget/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'expense_summary.dart';
double globalExpenseLimit = 50;

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget({Key? key}) : super(key: key);

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {
  final newExpenseNameController = TextEditingController();
  final newExpenseRublesController = TextEditingController();
  final newExpensePennyController = TextEditingController();

  final limitExpenseController = TextEditingController();

  final _expensesBox = Hive.box('expense_box');
  ExpenseDatabase db = ExpenseDatabase();




  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
    db.loadData();
    globalExpenseLimit = db.startExpenseLimit;

  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a new expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: newExpenseNameController,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: 'Name of the expense',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: newExpenseRublesController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          hintText: 'Rubles',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: newExpensePennyController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Penny',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: saveNewExpense,
                child: const Text('Save'),
              ),
              MaterialButton(
                onPressed: cancel,
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void saveNewExpense() {
    if (newExpenseNameController.text.isEmpty) return;
    if (newExpenseRublesController.text.isEmpty &&
        newExpensePennyController.text.isEmpty) return;

    String amount;
    if (newExpensePennyController.text.isEmpty) {
      amount = '${newExpenseRublesController.text}.00';
    } else if (newExpenseRublesController.text.isEmpty) {
      amount = '0.${newExpensePennyController.text}';
    } else {
      amount =
          '${newExpenseRublesController.text}.${newExpensePennyController.text}';
    }
    if (newExpensePennyController.text.length == 1) {}
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amount,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.of(context).pop();
    newExpenseNameController.clear();
    newExpenseRublesController.clear();
    newExpensePennyController.clear();
  }


  void installWeeklyLimit() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a new expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: limitExpenseController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Input weekly limit of expanses',
                  ),
                ),
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: saveWeeklyLimit,
                child: const Text('Save'),
              ),
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  void saveWeeklyLimit() {
    setState(() {
      if (limitExpenseController.text.isEmpty) return;
      db.startExpenseLimit = double.parse(limitExpenseController.text);
      globalExpenseLimit = db.startExpenseLimit;
      // expenseLimit = double.parse(limitExpenseController.text);
       //else {
      //   expenseLimit = null;
      // }
      Navigator.of(context).pop();
      db.updateDatabase();
    });
  }

  void cancel() {
    Navigator.of(context).pop();
    newExpenseNameController.clear();
    newExpenseRublesController.clear();
    newExpensePennyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    //final expenseLimit = this.expenseLimit;
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: installWeeklyLimit,
                    child: Text(
                      'Weekly limit: ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo[400]),
                    ),
                  ),
                  const SizedBox(width: 3),
                  //if (expenseLimit != null)
                    Text(
                      '${db.startExpenseLimit} BYN',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500,
                      ),
                    ),
                ],
              ),
            ),
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),
            const SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) {
                  return ExpenseTile(
                    name: value.getAllExpenseList()[index].name,
                    amount: value.getAllExpenseList()[index].amount,
                    dateTime: value.getAllExpenseList()[index].dateTime,
                    deleteFunction: (p0) =>
                        deleteExpense(value.getAllExpenseList()[index]),
                  );
                }),
            //if(value.getAllExpenseList()[index].dateTime.day != value.getAllExpenseList()[index + 1].dateTime.day){}
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo[300],
          onPressed: addNewExpense,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
