class NewProgress {
  String? key;
  int activeType;
  double amount;
  String datetime;
  String parentKey;

  NewProgress(this.activeType, this.amount, this.datetime, this.parentKey);

  NewProgress.fromJson(Map<dynamic, dynamic> json)
    : activeType = json['type'],
      amount = json['amount'].toDouble() as double,
      datetime = json['datetime'] as String,
      parentKey = json['parentKey'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'type': activeType,
    'amount': amount,
    'datetime': datetime,
    'parentKey': parentKey,
  };
}