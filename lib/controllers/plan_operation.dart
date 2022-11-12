import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/plan.dart';

class PlanOperation extends ChangeNotifier {
  final List<Plan> _plan = [];

  List<Plan> get getPlan {
    return _plan;
  }

  PlanOperation() {
    addNewPlan("Example", "Something", DateTime.now(), 10000);
  }

  void addNewPlan(String name, String category, DateTime planMade, double amount) {
    Plan plan = Plan(name, category, planMade, amount);
    _plan.add(plan);
    notifyListeners();
  }
}
