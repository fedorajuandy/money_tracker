import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/screens/add_plan_screen.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/widgets/title.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  int selectedIndex = DateTime.now().month + 1;
  final DateTime _selectedDate = DateTime.now();
  int _selectedYear = DateTime.now().year;
  DateTime now = DateTime.now();
  List <Widget> reports = [];
  String? yearText = "Other";
  List<String> years = <String>['2010', '2015', '2022'];

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
              padding: const EdgeInsets.only(top: 48, bottom: 24, right: 20, left: 20),
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
          plans(),
          plans(),
          sbh40(),
        ],
      ),
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
        children: List.generate(now.month + 1, (index) {
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

  Widget plans() {
    var size = MediaQuery.of(context).size;

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
                          "Plan name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: dark.withOpacity(0.6)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            "2022-12-31",
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
                            const Text(
                              "Rp0.00",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            sbw8(),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "50%",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: dark.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Text(
                            "Rp0.00",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: dark.withOpacity(0.6),
                            ),
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
                          width: (size.width - 80) * 0.5,
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