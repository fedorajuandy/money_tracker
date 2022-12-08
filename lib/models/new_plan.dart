class NewPlan {
  String? key;
  String name;
  double target;
  double currAmount = 0;
  String startDate;
  String endDate;
  double suggestedAmount = 0;

  NewPlan(this.name, this.target, this.currAmount, this.startDate, this.endDate);

  NewPlan.fromJson(Map<dynamic, dynamic> json)
    : name = json['name'] as String,
      target = json['target'] as double,
      currAmount = json['currAmount'] as double,
      startDate = json['startDate'] as String,
      endDate = json['endDate'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'name': name,
    'target': target,
    'currAmount': currAmount,
    'startDate': startDate,
    'endDate': endDate,
  };

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  void setSuggestedAmount() {
    DateTime date1 = DateTime.parse(startDate);
    DateTime date2 = DateTime.parse(endDate);

    suggestedAmount = target / daysBetween(date1, date2);
  }
  double getSuggestedAmount() {
    return suggestedAmount;
  }
}