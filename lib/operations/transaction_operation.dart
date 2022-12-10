import 'package:money_tracker/models/new_transaction.dart';
import 'package:firebase_database/firebase_database.dart';

class TransactionOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('transactions');

  Query getQuery() {
    return reference;
  }

  void add(NewTransaction n) {
    reference.push().set(n.toJson());
  }

  void update(NewTransaction n, String key) {
    reference.child(key).update(n.toJson());
  }

  void delete(String? key) {
    reference.child(key ?? "").remove();
  }
}
