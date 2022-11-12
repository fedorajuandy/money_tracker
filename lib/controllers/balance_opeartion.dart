import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/balance.dart';

class BalanceOperation extends ChangeNotifier {
  final List<Balance> _balance = [];

  List<Balance> get getBalance {
    return _balance;
  }

  BalanceOperation() {
    addNewBalance("Example", "Something", DateTime.now(), 10000);
  }

  void addNewBalance(String name, String category, DateTime BalanceMade, double amount) {
    Balance balance = Balance(name, category, BalanceMade, amount);
    _balance.add(balance);
    notifyListeners();
  }
}
