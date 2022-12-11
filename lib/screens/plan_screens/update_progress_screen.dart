import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/models/new_plan.dart';
import 'package:money_tracker/models/new_progress.dart';
import 'package:money_tracker/operations/progress_operation.dart';
import 'package:money_tracker/widgets/button.dart';
import 'package:money_tracker/widgets/textfield.dart';
import 'package:money_tracker/widgets/title.dart';

class UpdateProgressScreen extends StatefulWidget {
  const UpdateProgressScreen({Key? key, required this.planKey}) : super(key: key);
  final String planKey;

  @override
  State<UpdateProgressScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<UpdateProgressScreen> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _amountText = TextEditingController();
  late DatabaseReference dbProgress;
  late DatabaseReference dbPlan;
  late ProgressOperation progressOperation;
  DateTime now = DateTime.now();
  int activeType = 0;
  double currAmount = 0;

  @override
  void initState() {
    super.initState();
    String pk = widget.planKey;
    progressOperation = ProgressOperation(pk);
    dbProgress = FirebaseDatabase.instance.ref().child('plans/$pk/operations');
    dbPlan = FirebaseDatabase.instance.ref().child('plans');
    getPlanData();
  }

  void getPlanData() async {
    DataSnapshot snapshot = await dbPlan.child(widget.planKey).get();
    final json = snapshot.value as Map<dynamic, dynamic>;
    final plan = NewPlan.fromJson(json);

    currAmount = plan.getCurrAmount();
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
                titleWithBack("Progress list", context),
              ],
            ),
          ),
        ),
        // main screen
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                sbh32(),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Add or subtract?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dark.withOpacity(0.5),
                    ),
                  ),
                ),
                sbh20(),
                chooseType(),
                sbh40(),
                Padding(
                  padding:const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _keyform,
                    child: Column(
                      children: <Widget>[
                        textFieldNumber("Amount", _amountText, "Please input target amount"),
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

  Widget chooseType() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          typeAdd(),
          typeSubtract(),
        ],
      ),
    );
  }

  Widget typeAdd() {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeType = 0;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          width: 150,
          height: 170,
          decoration: BoxDecoration(
            color: white,
            border: Border.all(
              width: 2,
              color: activeType == 0 ? primary : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: dark.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                  ),
                ),
                const Text(
                  "Add",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget typeSubtract() {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeType = 1;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          width: 150,
          height: 170,
          decoration: BoxDecoration(
            color: white,
            border: Border.all(
              width: 2,
              color: activeType == 1 ? red : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: dark.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: red,
                  ),
                ),
                const Text(
                  "Subtract",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
          final newProgress = NewProgress(activeType, double.parse(_amountText.text), now.toString(), widget.planKey);
          progressOperation.add(newProgress);

          if(activeType == 0) {
            currAmount += double.parse(_amountText.text);
          } else {
            currAmount -= double.parse(_amountText.text);
          }

          Map<String, dynamic> plan = {
            'type': activeType,
            'currAmount': double.parse(_amountText.text),
          };

          dbPlan.child(widget.planKey).update(plan).then((value) => {
            Navigator.pop(context),
          });
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
