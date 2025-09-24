import 'package:expense_tracker/model/expense_item.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/expense_item_widget.dart';
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<ExpenseItem> expenseItems = [
    ExpenseItem(
      title: "Baon ni bunso",
      amount: 500,
      category: Category.food,
      date: DateTime.now(),
    ),
    ExpenseItem(
      title: "Pamasahe pang korea",
      amount: 2500,
      category: Category.travel,
      date: DateTime.now(),
    ),
    ExpenseItem(
      title: "Pera para sa perya",
      amount: 1500,
      category: Category.leisure,
      date: DateTime.now(),
    ),
  ];

  void _showAddExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(ExpenseItem expense) {
    setState(() {
      expenseItems.add(expense);
    });
  }

  void onRemoveExpense(ExpenseItem expense) {
    final index = expenseItems.indexOf(expense);
    setState(() {
      expenseItems.remove(expense);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              expenseItems.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense Tracker",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              _showAddExpense();
            },
          ),
        ],
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Chart"),
          //ListView
          expenseItems.isEmpty
              ? const Center(child: Text("No expenses yet.  Please add."))
              : Expanded(
                  child: ListView.builder(
                    itemCount: expenseItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: ValueKey(expenseItems[index]),
                        child: ExpenseItemWidget(expenseItems[index]),
                        onDismissed: (direction) {
                          onRemoveExpense(expenseItems[index]);
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
