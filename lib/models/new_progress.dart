class NewProgress {
  String? key;
  double amount;
  String datetime;
  String parentKey;

  NewProgress(this.amount, this.datetime, this.parentKey);

  NewProgress.fromJson(Map<dynamic, dynamic> json)
    : amount = json['amount'].toDouble() as double,
      datetime = json['datetime'] as String,
      parentKey = json['parentKey'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'amount': amount,
    'datetime': datetime,
    'parentKey': parentKey,
  };
}