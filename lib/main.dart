import 'package:flutter/material.dart';

import 'models/transaction.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final _transactions = [
    Transaction(
      id: "t1",
      title: "New Running Shoes",
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t2",
      title: "Electricity Bill",
      value: 211.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: "t3",
      title: "Car Bill",
      value: 111.11,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expenses"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Card(
            elevation: 5,
            child: Text("Chart"),
          ),
          Column(
            children: _transactions.map((tr) {
              return Card(
                child: Row(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      tr.value.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        tr.date.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ]),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
