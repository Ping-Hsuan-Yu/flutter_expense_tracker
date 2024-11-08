import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/widget/chart/chart.dart';
import 'package:flutter_expense_tracker/widget/expenses_list/expenses_list.dart';
import 'package:flutter_expense_tracker/model/expense.dart';
import 'package:flutter_expense_tracker/widget/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expensesList = [
    Expense(
        title: "Coffee",
        amount: 80,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "MRT Card",
        amount: 1280,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expensesList.indexOf(expense);
    setState(() {
      _expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text("刪除${expense.title}"),
      action: SnackBarAction(
          label: "反悔",
          onPressed: () {
            setState(() {
              _expensesList.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses, try add some!'),
    );

    if (_expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _expensesList,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expenses Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _expensesList),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
