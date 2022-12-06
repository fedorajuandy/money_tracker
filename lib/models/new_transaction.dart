import 'package:firebase_database/firebase_database.dart';

class NewTransaction {
  int? type;
  String? name;
  String? category;
  double? amount;
  DateTime? date;
  DateTime? time;

  NewTransaction(this.type, this.name, this.category, this.amount, this.date, this.time);

  NewTransaction.fromJson(Map<dynamic, dynamic> json)
    : type = json['type'] as int,
      name = json['name'] as String,
      category = json['category'] as String,
      amount = json['amount'] as double,
      date = json['date'] as DateTime,
      time = json['time'] as DateTime;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'type': type,
    'name': name,
    'category': category,
    'amount': amount,
    'date': date,
    'time': time,
  };

  /* NewTransaction.fromSnapshot(DataSnapshot dataSnapshot) {
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
  } */
}