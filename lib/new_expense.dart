import 'package:expense_tracker/model/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final void Function(ExpenseItem item) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  DateTime? _pickedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {
    _titleEditingController.dispose();
    _amountEditingController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountEditingController.text);

    widget.onAddExpense(
      ExpenseItem(
        title: _titleEditingController.text,
        amount: enteredAmount ?? 0.00,
        category: _selectedCategory,
        date: _pickedDate!,
      ),
    );
    Navigator.pop(context);
  }

  void _showDatePopup() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _pickedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMd();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleEditingController,
              decoration: InputDecoration(label: Text('Title')),
              keyboardType: TextInputType.text,
              maxLength: 50,
            ),
            TextField(
              controller: _amountEditingController,
              decoration: const InputDecoration(
                label: Text('Amount'),
                prefixText: '\$ ',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                _showDatePopup();
              },
              label: Text(
                textAlign: TextAlign.left,
                _pickedDate == null
                    ? "Please select a date"
                    : formatter.format(_pickedDate!),
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.calendar_today),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                overlayColor: Colors.white,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(2.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
              value: _selectedCategory,
              items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase()),
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
              },
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _submitExpenseData();
                  },
                  child: const Text("Add Expense"),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
