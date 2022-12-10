class NewTransaction {
  final int _type;
  final String _name;
  final String _category;
  final double _amount;
  final String _date;
  final String _time;

  NewTransaction(this._type, this._name, this._category, this._amount, this._date, this._time);

  int getType() {
    return _type;
  }

  String getName() {
    return _name;
  }

  String getCategory() {
    return _category;
  }

  double getAmount() {
    return _amount;
  }

  String getDate() {
    return _date;
  }

  String getTime() {
    return _time;
  }

  NewTransaction.fromJson(Map<dynamic, dynamic> json)
    : _type = json['type'] as int,
      _name = json['name'] as String,
      _category = json['category'] as String,
      _amount = json['amount'].toDouble() as double,
      _date = json['date'] as String,
      _time = json['time'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': _type,
    'name': _name,
    'category': _category,
    'amount': _amount,
    'date': _date,
    'time': _time,
  };
}
