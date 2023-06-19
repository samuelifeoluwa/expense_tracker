import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/charts/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    // Expense(
    //   category: Category.leisure,
    //   amount: 1500,
    //   title: 'cinema',
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   category: Category.leisure,
    //   amount: 5000,
    //   title: 'Football ticket',
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   category: Category.food,
    //   amount: 10000,
    //   title: 'Restaurant',
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   category: Category.travel,
    //   amount: 5000000,
    //   title: 'flight ticket',
    //   date: DateTime.now(),
    // ),
    // Expense(
    //   category: Category.work,
    //   amount: 500000000,
    //   title: 'Salary',
    //   date: DateTime.now(),
    //),
    Expense(
      category: Category.learning,
      amount: 15,
      title: 'Flutter course',
      date: DateTime.now(),
    ),
  ];

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(label: 'undo', onPressed: (() {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }),
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses found, start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 31, 56),
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => NewExpense(onAddExpense: addExpense),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Chart(expenses: _registeredExpenses),
            Expanded(
              child: mainContent,
            ),
          ],
        ),
      ),
    );
  }
}

// how to save the expense
//void _addExpense 