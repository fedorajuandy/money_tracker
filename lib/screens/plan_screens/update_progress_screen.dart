import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/models/new_progress.dart';
import 'package:money_tracker/operations/progress_operation.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
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
  late ProgressOperation progressOperation;
  DateTime now = DateTime.now();
  late DatabaseReference dbProgress;
  late DatabaseReference dbPlan;
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
    Map plan = snapshot.value as Map;
    currAmount = plan['currAmount'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark.withOpacity(0.05),
      body: screen(),
    );
  }

  Widget screen() {
    return SingleChildScrollView(
      child: Column(
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
                  titleWithBack("Progress list", context),
                ],
              ),
            ),
          ),
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
                  textFieldAmount(),
                  sbh32(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buttonCancel(),
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
              color: activeType == 0 ? primary : Colors.transparent
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
              color: activeType == 1 ? red : Colors.transparent
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

  Widget textFieldAmount() {
    return TextFormField(
      cursorColor: primary,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintText: "Amount",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Amount',
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
      controller: _amountText,
      validator: (value) {
        return (value !.isEmpty? "Please input target amount": null);
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
        final newProgress = NewProgress(double.parse(_amountText.text), now.toString(), widget.planKey);
        progressOperation.add(newProgress);

        if(activeType == 0) {
          currAmount += double.parse(_amountText.text);
        } else {
          currAmount -= double.parse(_amountText.text);
        }

        Map<String, dynamic> plan = {
          'currAmount': double.parse(_amountText.text),
        };

        dbPlan.child(widget.planKey).update(plan).then((value) => {
          Navigator.pop(context),
        });
      },
      child: const Text("Update plan"),
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