import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/new_transaction.dart';

class TransactionOperation extends ChangeNotifier {
  final List<NewTransaction> _transactions = [];

  List<NewTransaction> get getTransaction {
    return _transactions;
  }

  TransactionOperation() {
    addNewTransaction("Type", "Name", "Category", "10000", "2022-22-22", "00:00");
  }

  void addNewTransaction(String type, String name, String category, String amount, String date, String time) {
    NewTransaction transaction = NewTransaction(type, name, category, amount, date, time);
    _transactions.add(transaction);
    notifyListeners();
  }
}