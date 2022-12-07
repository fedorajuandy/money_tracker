import 'package:money_tracker/models/new_transaction.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('transactions');
  bool _exist = false;

  void add(NewTransaction n) {
    reference.push().set(n.toJson());
  }

  Query getQuery(String currDate) {
    print(reference.child("/date").toString());
    if (reference.child("/date").toString() == currDate) {
      _exist = true;
      print(_exist);
      return reference;
    } else {
      _exist = true;
      print(_exist);
      return reference;
      // return FirebaseDatabase.instance.ref().child('placeholders/transaction');
    }
  }

  bool getExist() {
    return _exist;
  }
  void setExist(bool a) {
    _exist = a;
  }
}