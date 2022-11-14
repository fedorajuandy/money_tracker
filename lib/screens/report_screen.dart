import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int selectedIndex = DateTime.now().month + 1;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
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
          graph(),
        ],
      ),
    );
  }

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const <Widget>[
        Text(
          "Reports",
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

  Widget graph() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
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
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Statistic",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: dark.withOpacity(0.3),
                      ),
                    ),
                    sbh10(),
                    const Text(
                      "Rp250,000.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 150,
                  child: Text("Yaya's here"),
                  // LineChart(mainData(),),
                ),
              ),
            ],
          ),
        ),
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