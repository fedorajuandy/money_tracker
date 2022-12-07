import 'package:money_tracker/models/new_plan.dart';
import 'package:firebase_database/firebase_database.dart';

class PlanOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans');

  void add(NewPlan n) {
    reference.push().set(n.toJson());
  }

  Query getQuery() {
    return reference;
  }
}