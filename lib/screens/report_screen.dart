import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/widgets/title.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // current month
  int selectedIndex = DateTime.now().month + 1;
  DateTime now = DateTime.now();
  List <Widget> reports = [];
  String? yearText = "Other";
  List<String> years = <String>['2010', '2015', '2022'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    reports = [
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
      report(),
      report1(),
    ];

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
              padding: const EdgeInsets.only(top: 24, bottom: 24, right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  title("Reports"),
                  sbh24(),
                  Column(
                    children: <Widget>[
                      chooseYear(),
                      sbh8(),
                      horisontalCalendar(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sbh32(),
          yearly(),
          sbh24(),
          monthly(),
          sbh40(),
        ],
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

  Widget chooseYear() {
    return DropdownButtonFormField <String>(
      value: "2022",
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: accent,
          ),
        ),
      ),
      items: years.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          yearText = value;
        });
      },
    );
  }

  Widget yearly() {
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
                      "Yearly values",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: dark.withOpacity(0.3),
                      ),
                    ),
                    sbh10(),
                    totalIncome(),
                    sbh8(),
                    totalExpenses(),
                    sbh8(),
                    highestIncome(),
                    sbh8(),
                    highestExpenses(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget total() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text(
            "Total",
            style: TextStyle(
              fontSize: 16,
              color: dark.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "Rp20,000.00",
              style: TextStyle(
                fontSize: 20,
                color: dark,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget totalExpenses() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text(
            "Expenses",
            style: TextStyle(
              fontSize: 16,
              color: dark.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "Rp20,000.00",
              style: TextStyle(
                fontSize: 20,
                color: dark,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget totalIncome() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text(
            "Income",
            style: TextStyle(
              fontSize: 16,
              color: dark.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "Rp20,000.00",
              style: TextStyle(
                fontSize: 20,
                color: dark,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget highestIncome() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text(
            "Highest income",
            style: TextStyle(
              fontSize: 16,
              color: dark.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "Month",
              style: TextStyle(
                fontSize: 20,
                color: dark,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget highestExpenses() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text(
            "Highest expenses",
            style: TextStyle(
              fontSize: 16,
              color: dark.withOpacity(0.4),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "Month",
              style: TextStyle(
                fontSize: 20,
                color: dark,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget monthly() {
    var size = MediaQuery.of(context).size;
    
    return Wrap(
      spacing: 20,
      children: <Widget> [
        Container(
          width: (size.width - 60) / 2,
          height: 170,
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
                    color: Colors.red,
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Expenses",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: dark,
                      ),
                    ),
                    sbh8(),
                    const Text(
                      "YATTA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: (size.width - 60) / 2,
          height: 170,
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
                    color: secondary,
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Income",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: dark,
                      ),
                    ),
                    sbh8(),
                    const Text(
                      "YATTA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget reportList() {
    return IndexedStack(
      index: selectedIndex,
      children: reports,
    );
  }

  Widget report() {
    return Text("YAYA");
  }

  Widget report1() {
    return Text("YAYA");
  }
}