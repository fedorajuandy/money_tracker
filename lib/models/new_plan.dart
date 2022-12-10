class NewPlan {
  final String _name;
  final double _target;
  final double _currAmount;
  final String _startDate;
  final String _endDate;

  NewPlan(this._name, this._target, this._currAmount, this._startDate, this._endDate);

  String getName() {
    return _name;
  }

  double getTarget() {
    return _target;
  }

  double getCurrAmount() {
    return _currAmount;
  }

  String getStartDate() {
    return _startDate;
  }

  String getEndDate() {
    return _endDate;
  }

  NewPlan.fromJson(Map<dynamic, dynamic> json)
    : _name = json['name'] as String,
      _target = json['target'].toDouble() as double,
      _currAmount = json['currAmount'].toDouble() as double,
      _startDate = json['startDate'] as String,
      _endDate = json['endDate'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': _name,
    'target': _target,
    'currAmount': _currAmount,
    'startDate': _startDate,
    'endDate': _endDate,
  };
}
