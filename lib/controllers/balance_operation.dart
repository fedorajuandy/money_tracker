import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/balance.dart';

class BalanceOperation extends ChangeNotifier {
  final List<Balance> _balance = [];

  List<Balance> get getBalance {
    return _balance;
  }

  BalanceOperation() {
    addNewBalance(100000);
  }

  void addNewBalance(double amount) {
    Balance balance = Balance(amount);
    _balance.add(balance);
    notifyListeners();
  }
}
