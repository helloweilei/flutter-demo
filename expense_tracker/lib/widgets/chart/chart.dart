import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.fromCategory(expenses, Category.food),
      ExpenseBucket.fromCategory(expenses, Category.leisure),
      ExpenseBucket.fromCategory(expenses, Category.travel),
      ExpenseBucket.fromCategory(expenses, Category.work),
    ];
  }

  double get totalAmount {
    double total = 0;
    for (var bucket in buckets) {
      total += bucket.totalAmount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 120,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: buckets
                  .map((e) => ChartBar(fill: e.totalAmount / totalAmount))
                  .toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buckets
                .map(
                  (bucket) => Icon(
                    categoryIcons[bucket.category],
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
