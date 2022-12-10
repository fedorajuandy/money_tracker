import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/models/new_plan.dart';
import 'package:money_tracker/operations/plan_operation.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/widgets/title.dart';

class AddPlanScreen extends StatefulWidget {
  const AddPlanScreen({super.key});

  @override
  State<AddPlanScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddPlanScreen> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _nameText = TextEditingController();
  final TextEditingController _targetText = TextEditingController();
  final TextEditingController _startDateText = TextEditingController();
  final TextEditingController _endDateText = TextEditingController();
  DateTime now = DateTime.now();
  late DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('plans');
  final planOperation = PlanOperation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: screen(),
    );
  }

  Widget screen() {
    return Column(
      children: <Widget>[
        // the 'header'
        Container(
          decoration: BoxDecoration(
            color: dark.withOpacity(0.05),
            boxShadow: [
              BoxShadow(
                color: dark.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 24, right: 20, left: 20),
            child: Column(
              children: <Widget>[
                titleWithBack("Add plan", context),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                sbh32(),
                Padding(
                  padding:const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _keyform,
                    child: Column(
                      children: <Widget>[
                        textFieldName(),
                        sbh20(),
                        textFieldTarget(),
                        sbh20(),
                        pickStartDate(),
                        sbh20(),
                        pickEndDate(),
                        sbh32(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buttonCancel(),
                            sbw8(),
                            buttonAdd(),
                          ],
                        ),
                        sbh40(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget textFieldName() {
    return TextFormField(
      cursorColor: primary,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintText: "Plan name",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Plan name',
        labelStyle: TextStyle(
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      controller: _nameText,
      validator: (value) {
        return (value !.isEmpty? "Please input plan name": null);
      },
    );
  }

  Widget textFieldTarget() {
    return TextFormField(
      cursorColor: primary,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintText: "Target",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Target',
        labelStyle: TextStyle(
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _targetText,
      validator: (value) {
        return (value !.isEmpty? "Please input target amount": null);
      },
    );
  }

  Widget pickStartDate() {
    return TextFormField(
      controller: _startDateText,
      readOnly: true,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Start date',
        labelStyle: TextStyle(
          color: primary,
        ),
        suffixIcon: Icon(
          Icons.calendar_month,
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      cursorColor: primary,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year - 10),
          lastDate: DateTime(now.year + 10),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            _startDateText.text = formattedDate;
          });
        }
      },
    );
  }

  Widget pickEndDate() {
    return TextFormField(
      controller: _endDateText,
      readOnly: true,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'End date',
        labelStyle: TextStyle(
          color: primary,
        ),
        suffixIcon: Icon(
          Icons.calendar_month,
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      cursorColor: primary,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year - 10),
          lastDate: DateTime(now.year + 10),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: primary,
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            _endDateText.text = formattedDate;
          });
        }
      },
    );
  }

  Widget buttonAdd() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: () {
        if (_keyform.currentState !.validate()) {
          final newPlan = NewPlan(_nameText.text, double.parse(_targetText.text), 0, _startDateText.text, _endDateText.text);
          planOperation.add(newPlan);
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please enter all required fields."),
            backgroundColor: primary,
          ));
        }
      },
      child: const Text("Add plan"),
    );
  }

  Widget buttonCancel() {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: white,
        foregroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: primary,
          ),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Cancel"),
    );
  }
}