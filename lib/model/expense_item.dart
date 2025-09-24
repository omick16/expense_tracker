import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpenseItem {
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  ExpenseItem({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  String get formattedDate {
    final formatter = DateFormat.yMd();
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseItem> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseItem> allExpenses, this.category)
    : expenses = allExpenses
          .where((expense) => expense.category == category)
          .toList();

  //computed property
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
