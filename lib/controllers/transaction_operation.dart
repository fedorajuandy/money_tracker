import 'package:money_tracker/models/new_transaction.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('transactions');

  void add(NewTransaction n) {
    reference.push().set(n.toJson());
  }

  Query getQuery() {
    return reference;
  }
}