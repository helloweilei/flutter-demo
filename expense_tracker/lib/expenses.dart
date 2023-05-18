import 'dart:ffi';

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'FLutter course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Travel to Zibo',
      amount: 16.99,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  final emptyList = const Center(
    child: Text('No expense found, please add some.'),
  );

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    final scaffoldMessage = ScaffoldMessenger.of(context);
    scaffoldMessage.hideCurrentSnackBar();
    scaffoldMessage.showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // var isDarkMode =
    //    MediaQuery.of(context).platformBrightness == Brightness.dark;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width <= 600
          ? Column(
              children: [
                Card(
                  child: Chart(expenses: _registeredExpenses),
                ),
                ExpenseList(
                  expenses: _registeredExpenses,
                  onRemoveExpense: _removeExpense,
                ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                ),
                ExpenseList(
                  expenses: _registeredExpenses,
                  onRemoveExpense: _removeExpense,
                ),
              ],
            ),
    );
  }
}
