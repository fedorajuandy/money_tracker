import 'package:money_tracker/models/new_transaction.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('transactions');
  bool _exist = false;

  void add(NewTransaction n) {
    reference.push().set(n.toJson());
  }

  Query getQuery() {
    return reference;
  }

  bool getExist() {
    return _exist;
  }
  void setExist(bool a) {
    _exist = a;
  }
}