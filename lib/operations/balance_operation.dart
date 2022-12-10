import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/models/balance.dart';

class BalanceOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('balance');
  final String _key = "user0";

  Query getQuery() {
    return reference;
  }

  void update(Balance n) {
    reference.child(_key).update(n.toJson());
  }
}
