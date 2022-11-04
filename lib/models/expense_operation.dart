import 'package:flutter/cupertino.dart';
import 'expense.dart';

class TasksOperation extends ChangeNotifier {
  final List<Expense> _tasks = [];

  List<Expense> get getTasks {
    return _tasks;
  }

  TasksOperation() {
    addNewTask("First task", "Example here; just enter whatever you want here.", "When will it finish? Or have to anyway.", "Some place");
  }

  void addNewTask(String title, String description, String dueDate, String? location) {
    Expense task = Expense(title, description, dueDate, location);
    _tasks.add(task);
    // like setState, broadcast the ones effected without reload
    notifyListeners();
  }
}
