import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/themes/text_formats.dart';
import 'package:money_tracker/models/new_plan.dart';
import 'package:money_tracker/operations/plan_operation.dart';
import 'package:money_tracker/widgets/button.dart';
import 'package:money_tracker/widgets/textfield.dart';
import 'package:money_tracker/widgets/title.dart';

class UpdatePlanScreen extends StatefulWidget {
  const UpdatePlanScreen({Key? key, required this.planKey}) : super(key: key);
  final String planKey;

  @override
  State<UpdatePlanScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<UpdatePlanScreen> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _nameText = TextEditingController();
  final TextEditingController _targetText = TextEditingController();
  final TextEditingController _startDateText = TextEditingController();
  final TextEditingController _endDateText = TextEditingController();
  late DatabaseReference dbPlan;
  final planOperation = PlanOperation();
  DateTime now = DateTime.now();
  double _currAmount = 0;

  @override
  void initState() {
    super.initState();
    dbPlan = FirebaseDatabase.instance.ref().child('plans');
    getPlanData();
  }

  void getPlanData() async {
    DataSnapshot snapshot = await dbPlan.child(widget.planKey).get();
    final json = snapshot.value as Map<dynamic, dynamic>;
    final plan = NewPlan.fromJson(json);

    _nameText.text = plan.getName();
    _targetText.text = plan.getTarget().toString();
    _currAmount = plan.getCurrAmount();
    _startDateText.text = plan.getStartDate();
    _endDateText.text = plan.getEndDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: screen(),
    );
  }

  Widget screen() {
    return Column(
      children: <Widget>[
        // header
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
                titleWithBack("Update plan", context),
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
                        textField("Plan name", _nameText, "Please input plan name"),
                        sbh20(),
                        textFieldNumber("Target amount", _targetText, "Please input target amount"),
                        sbh20(),
                        pickStartDate(),
                        sbh20(),
                        pickEndDate(),
                        sbh32(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buttonCancel(context),
                            sbw8(),
                            buttonUpdate(),
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
          String formattedDate = formatDate(pickedDate);
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
          String formattedDate = formatDate(pickedDate);
          setState(() {
            _endDateText.text = formattedDate;
          });
        }
      },
    );
  }

  Widget buttonUpdate() {
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
          final newPlan = NewPlan(_nameText.text, double.parse(_targetText.text), _currAmount, _startDateText.text, _endDateText.text);
          planOperation.update(newPlan, widget.planKey);

          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please enter all required fields."),
            backgroundColor: primary,
          ));
        }
      },
      child: const Text("Update plan"),
    );
  }
}
