class Balance {
  final double _amount;

  Balance(this._amount);

  double getAmount() {
    return _amount;
  }

  Balance.fromJson(Map<dynamic, dynamic> json)
    : _amount = json['amount'].toDouble() as double;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'amount': _amount,
  };
}
