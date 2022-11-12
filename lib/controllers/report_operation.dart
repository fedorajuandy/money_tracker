import 'package:flutter/cupertino.dart';
import 'package:money_tracker/models/report.dart';

class ReportOperation extends ChangeNotifier {
  final List<Report> _reports = [];

  List<Report> get getReport {
    return _reports;
  }

  ReportOperation() {
    addNewReport("Example", "Something", DateTime.now(), 10000);
  }

  void addNewReport(String name, String category, DateTime reportMade, double amount) {
    Report report = Report(name, category, reportMade, amount);
    _reports.add(report);
    notifyListeners();
  }
}
