class NewPlan {
  String? key;
  String name;
  double target;
  double currAmount;
  String addDate;
  String dueDate;
  double suggestedAmount = 0;

  NewPlan(this.name, this.target, this.currAmount, this.addDate, this.dueDate);

  NewPlan.fromJson(Map<dynamic, dynamic> json)
    : name = json['name'] as String,
      target = json['target'] as double,
      currAmount = json['currAmount'] as double,
      addDate = json['addDate'] as String,
      dueDate = json['dueDate'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'target': target,
    'currAmount': currAmount,
    'addDate': addDate,
    'dueDate': dueDate,
  };

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void setSuggestedAmount() {
    DateTime date1 = DateTime.parse(addDate);
    DateTime date2 = DateTime.parse(dueDate);

    suggestedAmount = target / daysBetween(date1, date2);
  }
  double getSuggestedAmount() {
    return suggestedAmount;
  }
}