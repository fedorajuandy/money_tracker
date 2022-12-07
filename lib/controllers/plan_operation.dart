import 'package:money_tracker/models/new_plan.dart';
import 'package:firebase_database/firebase_database.dart';

class PlanOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans');
  bool _exist = false;

  void add(NewPlan n) {
    reference.push().set(n.toJson());
  }

  Query getQuery(String currDate) {
    print(reference.child("/target").toString());
    if (reference.child("/target").toString() == currDate) {
      _exist = true;
      print(_exist);
      return reference;
    } else {
      _exist = false;
      print(_exist);
      return FirebaseDatabase.instance.ref().child('placeholders/plan');
    }
  }

  bool getExist() {
    return _exist;
  }
  void setExist(bool a) {
    _exist = a;
  }
}