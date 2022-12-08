import 'package:firebase_database/firebase_database.dart';

class BalanceOperation {
  final DatabaseReference reference = FirebaseDatabase.instance.ref().child('balance');

  Query getQuery() {
    return reference;
  }
}