class NewPlan {
  String name;
  double target;
  double currAmount;
  String dueDate;
  double suggestedAmount = 0;

  NewPlan(this.name, this.target, this.currAmount, this.dueDate);

  NewPlan.fromJson(Map<dynamic, dynamic> json)
    : name = json['name'] as String,
      target = json['target'] as double,
      currAmount = json['currAmount'] as double,
      dueDate = json['dueDate'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'target': target,
    'currAmount': currAmount,
    'dueDate': dueDate,
  };
}
