
import 'package:hive/hive.dart';

import '../../ui/widgets/expense_widget/expense_item.dart';

class ExpenseDatabase {
  final _expensesBox = Hive.box('expense_box');
  double startExpenseLimit = 15;

  // void createInitialData(){
  //   startExpenseLimit = 50;
  // }

  void loadData(){
    startExpenseLimit = _expensesBox.get('EXPENSE_LIMIT');
  }

  void updateDatabase(){
    _expensesBox.put('EXPENSE_LIMIT', startExpenseLimit);
  }

  void saveData (List<ExpenseItem> allExpenses){

    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpenses){
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _expensesBox.put('ALL_EXPENSES', allExpensesFormatted);
  }

  List<ExpenseItem> readData(){
    List savedExpenses = _expensesBox.get('ALL_EXPENSES') ?? [];
    List<ExpenseItem> allExpenses = [];
    for(int i = 0; i < savedExpenses.length; i++){
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];
      ExpenseItem expense = ExpenseItem(
          name: name,
          amount: amount,
          dateTime: dateTime
      );
      allExpenses.add(expense);
    }
    return allExpenses;
  }



}
