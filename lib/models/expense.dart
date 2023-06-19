import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

//to generate a unique id for the expense
const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work,
  learning,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.learning: Icons.school
};

class Expense {
  Expense(
      {required this.category,
      required this.amount,
      required this.title,
      required this.date})
      : id = uuid.v4();

  final String id;
  final double amount;
  final String title;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}

// chart
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where(
              (expense) => expense.category == category,
            )
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; //sum = sum + expense.amount;
    }
    return sum;
  }
}
