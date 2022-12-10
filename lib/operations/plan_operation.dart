import 'package:money_tracker/models/new_plan.dart';
import 'package:firebase_database/firebase_database.dart';

class PlanOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans');

  Query getQuery() {
    return reference;
  }

  void add(NewPlan n) {
    reference.push().set(n.toJson());
  }

  void update(NewPlan n, String key) {
    reference.child(key).update(n.toJson());
  }

  void delete(String? key) {
    reference.child(key ?? "").remove();
  }
}
