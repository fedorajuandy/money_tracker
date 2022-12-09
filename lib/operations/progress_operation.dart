import 'package:money_tracker/models/new_progress.dart';
import 'package:firebase_database/firebase_database.dart';

class ProgressOperation {
  String key;
  ProgressOperation(this.key);

  void add(NewProgress n) {
    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans/$key/operations');
    reference.push().set(n.toJson());
  }

  Query getQuery() {
    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans/$key/operations');
    return reference;
  }
}