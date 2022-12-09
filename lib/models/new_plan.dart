class NewPlan {
  String? key;
  String name;
  double target;
  double currAmount = 0;
  String startDate;
  String endDate;

  NewPlan(this.name, this.target, this.currAmount, this.startDate, this.endDate);

  NewPlan.fromJson(Map<dynamic, dynamic> json)
    : name = json['name'] as String,
      target = json['target'].toDouble() as double,
      currAmount = json['currAmount'].toDouble() as double,
      startDate = json['startDate'] as String,
      endDate = json['endDate'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'target': target,
    'currAmount': currAmount,
    'startDate': startDate,
    'endDate': endDate,
  };
}