class NewTransaction {
  String? key;
  int type;
  String name;
  String category;
  double amount;
  String date;
  String time;

  NewTransaction(this.type, this.name, this.category, this.amount, this.date, this.time);

  NewTransaction.fromJson(Map<dynamic, dynamic> json)
    : type = json['type'] as int,
      name = json['name'] as String,
      category = json['category'] as String,
      amount = json['amount'] as double,
      date = json['date'] as String,
      time = json['time'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'type': type,
    'name': name,
    'category': category,
    'amount': amount,
    'date': date,
    'time': time,
  };

  void setKey(String a) {
    key = a;
  }

  String? getKey() {
    return key;
  }
}