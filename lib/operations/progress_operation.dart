import 'package:money_tracker/models/new_progress.dart';
import 'package:firebase_database/firebase_database.dart';

class ProgressOperation {
  final String _key;

  ProgressOperation(this._key);

  Query getQuery() {
    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans/$_key/operations');
    return reference;
  }

  void add(NewProgress n) {
    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans/$_key/operations');
    reference.push().set(n.toJson());
  }

  void update(NewProgress n, String key) {
    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans/$_key/operations');
    reference.child(key).update(n.toJson());
  }

  void delete(String? key) {
    final DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans/$_key/operations');
    reference.child(key ?? "").remove();
  }
}
