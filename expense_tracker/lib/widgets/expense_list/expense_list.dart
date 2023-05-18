import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final List<Expense> expenses;

  final void Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: expenses.isEmpty
          ? const Center(
              child: Text('No expense found, please add some.'),
            )
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (ctx, index) => Dismissible(
                  key: ValueKey(expenses[index]),
                  onDismissed: (direction) {
                    onRemoveExpense(expenses[index]);
                  },
                  background: Container(
                    color: Theme.of(context).colorScheme.error,
                    margin: EdgeInsets.symmetric(
                      horizontal:
                          Theme.of(context).cardTheme.margin!.horizontal,
                    ),
                  ),
                  child: ExpenseItem(
                    expenses[index],
                  )),
            ),
    );
  }
}
