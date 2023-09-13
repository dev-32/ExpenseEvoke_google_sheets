import 'package:flutter/material.dart';
class MyTransactions extends StatelessWidget {
  const MyTransactions({super.key, required this.transactionName,
  required this.money, required this.expenseOrIncome});
  final String transactionName;
  final String money;
  final String expenseOrIncome;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.grey[200],
        height: 55,
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(transactionName),
                Text('${expenseOrIncome == 'expense' ? '-' : '+ '}₹$money',
                style: TextStyle(
                  color:
                  expenseOrIncome == 'expense' ? Colors.red :Colors.green,
                  fontWeight: FontWeight.bold,

                  ),
                ),
              ],
            )),
      ),
    );
  }
}
