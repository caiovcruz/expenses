import 'dart:math';

import 'package:flutter/material.dart';

import 'components/chart.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({Key? key}) : super(key: key);

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
            headline6: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            button: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Old Bill',
      value: 400.00,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: 'New Running Shoes',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Electricity Bill',
      value: 211.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Car Bill',
      value: 111.11,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't4',
      title: 'Trash Car',
      value: 1011.11,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't5',
      title: 'Old Car',
      value: 10111.11,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't6',
      title: 'New Car',
      value: 20111.11,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere(
        (tr) => tr.id == id,
      );
    });
  }

  _openTransactionModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TransactionForm(onSubmit: _addTransaction);
        },
        isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        if (isLandscape)
          IconButton(
            icon: Icon(_showChart
                ? Icons.list_alt
                : Icons.insert_chart_outlined_outlined),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openTransactionModal(context),
        ),
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.8 : 0.3),
                child: Chart(
                  recentTransaction: _recentTransaction,
                ),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(
                  transactions: _transactions.reversed.toList(),
                  onDelete: _deleteTransaction,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
