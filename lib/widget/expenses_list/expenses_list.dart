import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/model/expense.dart';
import 'package:flutter_expense_tracker/widget/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        //builder will build the widget when it need, not when the code is executed
        itemCount: expenses.length, //the final count builder will build
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onRemoveExpense(expenses[index]);
            },
            background: Container(
              color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.5),
              margin: Theme.of(context).cardTheme.margin,
            ),
            child: ExpenseItem(expenses[index])),
      ),
    );
  }
}
