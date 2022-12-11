import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/themes/text_formats.dart';
import 'package:money_tracker/models/new_plan.dart';
import 'package:money_tracker/operations/plan_operation.dart';
import 'package:money_tracker/screens/plan_screens/add_plan_screen.dart';
import 'package:money_tracker/screens/plan_screens/progress_screen.dart';
import 'package:money_tracker/screens/plan_screens/update_plan_screen.dart';
import 'package:money_tracker/widgets/title.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('plans');
  final planOperation = PlanOperation();
  DateTime now = DateTime.now();
  late DateTime _selectedDate;
  late int _selectedIndex;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedDate = now;
    // current month
    _selectedIndex = now.month - 1;
    _selectedYear = now.year;

    WidgetsBinding.instance.addPostFrameCallback((_){
      fal();
    });
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
        // main screen
        Expanded(
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                sbh32(),
                fal(),
              ],
            ),
          ),
        ),
        sbh40(),
      ],
    );
  }

  Widget fal() {
    return FirebaseAnimatedList(
      query: planOperation.getQuery(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final plan = NewPlan.fromJson(json);
        String dd = plan.getEndDate();

        if (dd.substring(0, 4) == _selectedYear.toString() && dd.substring(5, 7) == (_selectedIndex + 1).toString()) {
          return planList(snapshot.key, plan.getName(), plan.getTarget(), plan.getCurrAmount(), plan.getStartDate(), plan.getEndDate());
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
        _selectedYear.toString(),
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
      content: SizedBox(
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
        children: List.generate(now.month, (index) {
          final monthName = DateFormat("MMMM").format(DateTime(now.year, index + 1, 1));

          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0.0, right: 16.0),
            child: GestureDetector(
              onTap: () => setState(() {
                _selectedIndex = index;
              }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // month's name (MMM)
                  Container(
                    decoration: BoxDecoration(
                      color: _selectedIndex == index ? primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: _selectedIndex == index ? primary : dark.withOpacity(0.1),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 7, bottom: 7, right: 12, left: 12),
                      child: Text(
                        monthName.substring(0, 3),
                        style: TextStyle(
                          fontSize: 14,
                          color: _selectedIndex == index ? Colors.white : dark,
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
                    // upper part
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // plan name
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: dark.withOpacity(0.6)),
                        ),
                        // end date
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
                    // middle part
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // target amount
                        Row(
                          children: <Widget>[
                            Text(
                              CurrencyFormat.convertToIdr(target, 2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        // actions
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // add progress
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
                              // edit
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
                              // delete
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Confirmation"),
                                        content: const Text("Would you like to delete selected item?"),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: dark.withOpacity(0.5),
                                              fixedSize: const Size.fromWidth(100),
                                              padding: const EdgeInsets.all(10),
                                            ),
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: primary,
                                              fixedSize: const Size.fromWidth(100),
                                              padding: const EdgeInsets.all(10),
                                            ),
                                            child: const Text("Yes"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              reference.child(key ?? "").remove();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
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
                    sbh12(),
                    // bottom part
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // suggested amount
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            "Per day: ${CurrencyFormat.convertToIdr(calculateSA(target, startDate, endDate), 2)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: dark.withOpacity(0.6),
                            ),
                          ),
                        ),
                        // progress number
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                CurrencyFormat.convertToIdr(currAmount, 2),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: dark.withOpacity(0.6),
                                ),
                              ),
                            ),
                            sbw8(),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "${num.parse(progress.toStringAsFixed(2))}%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: dark.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    sbh16(),
                    // progress bar
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

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  double suggestedAmount = 0;
  double calculateSA(double target, String startDate, String endDate) {
    DateTime date1 = DateTime.parse(startDate);
    DateTime date2 = DateTime.parse(endDate);

    suggestedAmount = target / daysBetween(date1, date2);
    return suggestedAmount;
  }
}
