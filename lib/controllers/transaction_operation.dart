import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/new_transaction.dart';

class TransactionOperation extends ChangeNotifier {
  final List<NewTransaction> _transactions = [];

  List<NewTransaction> get getTransaction {
    return _transactions;
  }

  TransactionOperation() {
    addNewTransaction(0, "Name", "Category", 0, DateTime.now(), DateTime.now());
  }

  void addNewTransaction(int type, String name, String category, double amount, DateTime date, DateTime time) {
    NewTransaction transaction = NewTransaction(type, name, category, amount, date, time);
    _transactions.add(transaction);
    notifyListeners();
  }
}