import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _controller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime? selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firtDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: firtDate, lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(amountcontroller.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_controller.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      //show error message

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(' Invalid Input'),
          content: const Text(
              'Please check all input data.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(Expense(
        category: _selectedCategory,
        amount: enteredAmount,
        title: _controller.text,
        date: selectedDate!),);
        Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16,top: 50,right: 16,bottom: 16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: amountcontroller,
                    decoration: const InputDecoration(
                        label: Text('amount'), prefixText: '\$ '),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(selectedDate == null
                          ? 'Select Date'
                          : formatter.format(selectedDate!),
                          style: Theme.of(context).textTheme.titleLarge,),
                      IconButton(
                        onPressed: _presentDatePicker,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    }),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'cancel',
                    ),
                  ),
                ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text('save expense '),
                ),
              ],
            )
          ],
        ));
  }
}
