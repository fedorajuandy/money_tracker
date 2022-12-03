import 'package:firebase_database/firebase_database.dart';

class NewTransaction {
  String? type;
  String? name;
  String? category;
  String? amount;
  String? date;
  String? time;

  NewTransaction(this.type, this.name, this.category, this.amount, this.date, this.time);

  NewTransaction.fromSnapshot(DataSnapshot dataSnapshot) {
    type = (dataSnapshot.child("type").value.toString());
    name = (dataSnapshot.child("name").value.toString());
    category = (dataSnapshot.child("category").value.toString());
    amount = (dataSnapshot.child("amount").value.toString());
    date = (dataSnapshot.child("date").value.toString());
    time = (dataSnapshot.child("time").value.toString());
  }

  String? getType() {
    return type;
  }
  String? getName() {
    return name;
  }
  String? getCategory() {
    return category;
  }
  String? getAmount() {
    return amount;
  }
  String? getDate() {
    return date;
  }
  String? getTime() {
    return time;
  }
}