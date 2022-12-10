class NewProgress {
  final int _activeType;
  final double _amount;
  final String _datetime;
  final String _parentKey;

  NewProgress(this._activeType, this._amount, this._datetime, this._parentKey);

  int getActiveType() {
    return _activeType;
  }

  double getAmount() {
    return _amount;
  }

  String getDatetime() {
    return _datetime;
  }

  String getParentKey() {
    return _parentKey;
  }

  NewProgress.fromJson(Map<dynamic, dynamic> json)
    : _activeType = json['type'],
      _amount = json['amount'].toDouble() as double,
      _datetime = json['datetime'] as String,
      _parentKey = json['parentKey'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'type': _activeType,
    'amount': _amount,
    'datetime': _datetime,
    'parentKey': _parentKey,
  };
}
