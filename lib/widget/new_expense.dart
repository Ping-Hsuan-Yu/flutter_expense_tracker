import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_expense_tracker/model/expense.dart';

final formatter = DateFormat('y/M/d');

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: Text("輸入資料不完整"),
                content: Text("品項價錢日期都要填喔～"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text("懂"))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("輸入資料不完整"),
                content: Text("品項價錢日期都要填喔～"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text("懂"))
                ],
              ));
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final landscape = constraints.maxWidth > constraints.maxHeight;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (landscape)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            label: Text("品項"),
                          ),
                          controller: _titleController,
                          maxLength: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.date_range)),
                            Text(_selectedDate == null
                                ? "日期"
                                : formatter.format(_selectedDate!)),
                          ],
                        ),
                      )
                    ],
                  )
                else
                  TextField(
                    decoration: const InputDecoration(
                      label: Text("品項"),
                    ),
                    controller: _titleController,
                    maxLength: 50,
                  ),
                if (landscape)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            prefixText: "\$ ",
                            label: Text("價錢"),
                          ),
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: DropdownButton(
                            value: _selectedCategory,
                            items: Category.values
                                .map((cat) => DropdownMenuItem(
                                      value: cat,
                                      child: Text(
                                          cat.name.toString().toUpperCase()),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value!;
                              });
                            }),
                      ),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            prefixText: "\$ ",
                            label: Text("價錢"),
                          ),
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.date_range)),
                            Text(_selectedDate == null
                                ? "日期"
                                : formatter.format(_selectedDate!)),
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (landscape)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("取消")),
                      ElevatedButton(
                          onPressed: _submitExpenseData, child: Text("儲存")),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((cat) => DropdownMenuItem(
                                    value: cat,
                                    child:
                                        Text(cat.name.toString().toUpperCase()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("取消")),
                      ElevatedButton(
                          onPressed: _submitExpenseData, child: Text("儲存")),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
