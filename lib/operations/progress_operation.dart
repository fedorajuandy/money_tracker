import 'package:money_tracker/models/new_progress.dart';
import 'package:firebase_database/firebase_database.dart';

class ProgressOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans/operations');

  void add(NewProgress n) {
    reference.push().set(n.toJson());
  }

  Query getQuery() {
    return reference;
  }
}