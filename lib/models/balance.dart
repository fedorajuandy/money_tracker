class Balance {
  double amount;

  Balance(this.amount);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'amount': amount,
  };
}
