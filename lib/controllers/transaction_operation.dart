import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/transaction.dart';

class TransactionOperation extends ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get getTransaction {
    return _transactions;
  }

  TransactionOperation() {
    addNewTransaction("Transaction name", "Expense", "Category", 10000, DateTime.now());
  }

  void addNewTransaction(String name, String type, String category, double amount, DateTime transactionMade) {
    Transaction transaction = Transaction(name, type, category, amount, transactionMade);
    _transactions.add(transaction);
    notifyListeners();
  }
}