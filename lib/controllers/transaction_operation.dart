import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/transaction.dart';

class TransactionOperation extends ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get getTransaction {
    return _transactions;
  }

  TransactionOperation() {
    addNewTransaction("Example", "Something", DateTime.now(), 10000);
  }

  void addNewTransaction(String name, String? category, DateTime transactionMade, double amount) {
    Transaction transaction = Transaction(name, category, transactionMade, amount);
    _transactions.add(transaction);
    notifyListeners();
  }
}
