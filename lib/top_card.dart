import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({required this.balance,
   required this.income, required this.expense});
  final String balance;
  final String income;
  final String expense;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[300],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade50,
              offset:const Offset(4.0,4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0
            ),
             const BoxShadow(
              color: Colors.white70,
              offset : Offset(-4.0,-4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0
            )
          ]
        ),
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('B A L A N C E',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),),
              Text('₹$balance',
                style: TextStyle(color: Colors.grey[800], fontSize: 40),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white54
                        ),
                        child: const Icon(Icons.arrow_upward,
                        color: Colors.green,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          Text('Income',
                          style: TextStyle(
                            color: Colors.grey.shade800
                          ),),
                          Text('₹$income',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white54
                        ),
                        child: const Icon(Icons.arrow_downward,
                        color: Colors.red,
                        size: 40,),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        children: [
                          Text('Expense',
                            style: TextStyle(
                                color: Colors.grey.shade800
                            ),),
                          Text('₹$expense',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),),

                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
