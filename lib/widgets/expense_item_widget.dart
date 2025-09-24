import 'package:expense_tracker/model/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseItemWidget extends StatelessWidget {
  final ExpenseItem item;

  const ExpenseItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Colors.pink.shade100,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$ ${item.amount.toString()}"),
                const Spacer(),
                Icon(categoryIcons[item.category]),
                const SizedBox(width: 5),
                Text(item.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
