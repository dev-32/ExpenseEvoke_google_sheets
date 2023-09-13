import 'dart:async';

import 'package:expense_tracker_google_sheets/google_sheets_api.dart';
import 'package:expense_tracker_google_sheets/plus_button.dart';
import 'package:expense_tracker_google_sheets/top_card.dart';
import 'package:expense_tracker_google_sheets/transaction.dart';
import 'package:flutter/material.dart';

import 'loading_circle.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;
  bool timerHasStarted = false;
  void _enterTransaction() {
    GoogleSheetApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                title: const Text('N E W  T R A N S A C T I O N',
                style:  TextStyle(
                  fontSize: 16,
                ),),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Expense'),
                          Switch(
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text('Income'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Amount?',
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'For what?',
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                    color: Colors.grey[600],
                    child:
                    Text('Cancel', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  MaterialButton(
                    color: Colors.grey[600],
                    child: Text('Enter', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _enterTransaction();
                        Navigator.of(context).pop();
                      }
                    },
                  )
                ],
              );
            },
          );
        });
  }


  void startLoading(){
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer){
      if(GoogleSheetApi.loading == true){
        setState(() {});
        timer.cancel();
      }
    });
    setState(() {

    });
    print("Current: " + GoogleSheetApi.currentTransactions.toString());

  }
  @override
  Widget build(BuildContext context) {
    if(GoogleSheetApi.loading == true && timerHasStarted == false){
      startLoading();
    }
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          TopCard(
            balance: (GoogleSheetApi.calculateIncome()-GoogleSheetApi.calculateExpense()).toString(),
            income: GoogleSheetApi.calculateIncome().toString(),
            expense: GoogleSheetApi.calculateExpense().toString(),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left:22,right: 22),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                Expanded(
                  child:
                  GoogleSheetApi.loading == true
                    ? const LoadingCircle():
                      ListView.builder(
                    itemCount: GoogleSheetApi.currentTransactions.length,
                    itemBuilder:(context, index){
                      return MyTransactions(transactionName: GoogleSheetApi.currentTransactions[index][0],
                          money: GoogleSheetApi.currentTransactions[index][1],
                          expenseOrIncome: GoogleSheetApi.currentTransactions[index][2]);
                    })),
                  ],
                ),
              ),
            ),
          ),
          PlusButton(function: _newTransaction,),
        ],
      ),
    );
  }
}
