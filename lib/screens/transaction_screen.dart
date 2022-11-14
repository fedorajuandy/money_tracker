import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int selectedIndex = DateTime.now().day - 1;
  DateTime now = DateTime.now();
  // late = when runtime
  late DateTime lastDayOfMonth;

  @override
  void initState() {
    super.initState();
    // get the next month, then take a step back to the last day (the last '0')
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
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
              padding: const EdgeInsets.only(top: 60, bottom: 25, right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  title(),
                  sbh28(),
                  Column(
                    children: <Widget>[
                      horisontalCalendar(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sbh28(),
        ],
      ),
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        Text(
          "Transactions",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: dark,
          ),
        ),
      ],
    );
  }

  Widget horisontalCalendar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Row(
        children: List.generate(lastDayOfMonth.day, (index) {
          final currDate = lastDayOfMonth.add(Duration(days: index + 1));
          final dayName = DateFormat("E").format(currDate);

          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 16.0 : 0.0, right: 16.0),
            child: GestureDetector(
              onTap: () => setState(() {
                selectedIndex = index;
              }),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    dayName.substring(0, 3),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  sbh10(),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? primary : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedIndex == index ? primary : dark.withOpacity(0.1),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 10.0,
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

  Widget transaction() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: (MediaQuery.of(context).size.width - 40) * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "",
                      style: TextStyle(
                        fontSize: 16,
                        color: dark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    sbh8(),
                    Text(
                      "",
                      style: TextStyle(
                        fontSize: 12,
                        color: dark.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 40) * 0.3,
                child: Row(
                  children: const <Widget>[
                    Text(
                      "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 64, top: 8),
            child: Column(
              children: <Widget>[
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: dark.withOpacity(0.4),
                  ),
                ),
                const Text(
                  "RpTotal",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: dark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sbh8() {
    return const SizedBox(height: 8);
  }

  Widget sbh10() {
    return const SizedBox(height: 10);
  }

  Widget sbh28() {
    return const SizedBox(height: 28);
  }
}