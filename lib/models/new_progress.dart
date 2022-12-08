class NewProgress {
  String? key;
  double amount;
  String datetime;

  NewProgress(this.amount, this.datetime);

  NewProgress.fromJson(Map<dynamic, dynamic> json)
    : amount = json['amount'] as double,
      datetime = json['datetime'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'amount': amount,
    'datetime': datetime,
  };
}