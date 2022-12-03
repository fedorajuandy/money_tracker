import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/plan.dart';

class PlanOperation extends ChangeNotifier {
  final List<Plan> _plan = [];

  List<Plan> get getPlan {
    return _plan;
  }

  PlanOperation() {
    addNewPlan("Plan name", "Category", 10000, DateTime.now());
  }

  void addNewPlan(String name, String category, double amount, DateTime planMade) {
    Plan plan = Plan(name, category, amount, planMade);
    _plan.add(plan);
    notifyListeners();
  }
}
