class Balance {
  double amount = 0;

  Balance(this.amount);

  Balance.fromJson(Map<dynamic, dynamic> json)
    : amount = json['amount'].toDouble() as double;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'amount': amount,
  };
}
