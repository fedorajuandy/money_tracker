import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/models/new_plan.dart';
import 'package:money_tracker/operations/plan_operation.dart';
import 'package:money_tracker/screens/plan_screens/add_plan_screen.dart';
import 'package:money_tracker/screens/plan_screens/progress_screen.dart';
import 'package:money_tracker/screens/plan_screens/update_plan_screen.dart';
import 'package:money_tracker/screens/plan_screens/update_progress_screen.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/currency_format.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/widgets/title.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  int selectedIndex = DateTime.now().month - 1;
  final DateTime _selectedDate = DateTime.now();
  int _selectedYear = DateTime.now().year;
  DateTime now = DateTime.now();
  String? yearText = "Other";
  final planOperation = PlanOperation();
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      fat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark.withOpacity(0.05),
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
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        title("Plans"),
                        sbw8(),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: addPlanButton(),
                        ),
                      ],
                    ),
                    const Spacer(),
                    yearPicker(),
                  ],
                ),
                sbh24(),
                Column(
                  children: <Widget>[
                    sbh8(),
                    horisontalCalendar(),
                  ],
                ),
              ],
            ),
          ),
        ),
        sbh32(),
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                fat(),
              ],
            ),
          ),
        ),
        sbh40(),
      ],
    );
  }

  Widget fat() {
    return FirebaseAnimatedList(
      query: planOperation.getQuery(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        String dd = snapshot.child("/endDate").value.toString();
        if (dd.substring(0, 4) == _selectedYear.toString() && dd.substring(5, 7) == (selectedIndex + 1).toString()) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final plan = NewPlan.fromJson(json);
          return planList(snapshot.key, plan.name, plan.target, plan.currAmount, plan.startDate, plan.endDate);
        } else {
          return Container();
        }
      },
      physics: const ScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget addPlanButton() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text(
        "Add plan",
        style: TextStyle(
          color: white,
          fontSize: 14,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AddPlanScreen()),
        );
      },
    );
  }

  Widget yearPicker() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(
            color: dark,
          ),
        ),
      ),
      child: Text(
        now.year.toString(),
        style: const TextStyle(
          color: dark,
          fontSize: 12,
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return pickYear();
          },
        );
      },
    );
  }

  Widget pickYear() {
    return AlertDialog(
      title: const Text("Select Year"),
      content: SizedBox( // Need to use container to add size constraint.
        width: 300,
        height: 300,
        child: YearPicker(
          firstDate: DateTime(now.year - 10, 1, 1),
          lastDate: DateTime(now.year + 10, 1, 1),
          initialDate: now,
          selectedDate: _selectedDate,
          onChanged: (DateTime value) {
            setState(() {
              _selectedYear = value.year;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget horisontalCalendar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Row(
        // generate in a loop < months
        children: List.generate(now.month, (index) {
          final monthName = DateFormat("MMMM").format(DateTime(now.year, index + 1, 1));

          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0.0, right: 16.0),
            child: GestureDetector(
              onTap: () => setState(() {
                selectedIndex = index;
              }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // month's name (MMM)
                  Container(
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: selectedIndex == index ? primary : dark.withOpacity(0.1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7, bottom: 7, right: 12, left: 12),
                      child: Text(
                        monthName.substring(0, 3),
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedIndex == index ? Colors.white : dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget planList(String? key, String name, double target, double currAmount, String startDate, String endDate) {
    var size = MediaQuery.of(context).size;
    double progress = (currAmount / target) * 100;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: dark.withOpacity(0.01),
                    spreadRadius: 10,
                    blurRadius: 3,
                  ),
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: dark.withOpacity(0.6)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            endDate,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: dark.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sbh12(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              CurrencyFormat.convertToIdr(target, 2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            sbw8(),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "$progress%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: dark.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProgressScreen(planKey: key ?? "")));
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.add,
                                      color: dark.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                              sbw8(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => UpdatePlanScreen(planKey: key ?? "")));
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.edit,
                                      color: primary,
                                    ),
                                  ],
                                ),
                              ),
                              sbw8(),
                              GestureDetector(
                                onTap: () {
                                  reference.child(key ?? "").remove();
                                },
                                child: Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.delete,
                                      color: red,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    sbh16(),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: (size.width - 80),
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: dark.withOpacity(0.1),
                          ),
                        ),
                        Container(
                          width: (size.width - 80) * progress / 100,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: secondary,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
      ]),
    );
  }
}