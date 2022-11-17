import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:intl/intl.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  // today's date
  int selectedIndex = DateTime.now().day - 1;
  DateTime now = DateTime.now();
  // late = when runtime, not when initialised
  late DateTime lastDayOfMonth;
  List <Widget> transactions = [];

  @override
  void initState() {
    super.initState();
    // get the next month, then take a step back to the last day (the last '0')
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    transactions = [
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
      transaction(),
      transaction1(),
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
                  blurRadius: 3,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 25, right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  title(),
                  sbh24(),
                  Column(
                    children: <Widget>[
                      horisontalCalendar(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          sbh32(),
          transactionList(),
          sbh16(),
          total(),
          sbh40(),
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
        // generate in a loop < lastDayOfMonth
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
                  // days
                  Text(
                    dayName.substring(0, 3),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  sbh10(),
                  // dates
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
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: selectedIndex == index ? Colors.white : dark,
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

  Widget transactionList() {
    return IndexedStack(
      index: selectedIndex,
      children: transactions,
    );
  }

  Widget transaction() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // left part (name and category)
              SizedBox(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: (size.width - 90) * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Transaction name",
                            style: TextStyle(
                              fontSize: 14,
                              color: dark,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          sbh4(),
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 12,
                              color: dark.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              // right part (amount and time)
              SizedBox(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: (size.width - 90) * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const Text(
                            "Rp10,000.00",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: secondary,
                            ),
                          ),
                          sbh4(),
                          Text(
                            "10:40",
                            style: TextStyle(
                              fontSize: 12,
                              color: dark.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          horisontalLine(),
        ],
      ),
    );
  }

  Widget transaction1() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // left part (name and category)
              SizedBox(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: (size.width - 90) * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Transaction name 1",
                            style: TextStyle(
                              fontSize: 14,
                              color: dark,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          sbh4(),
                          Text(
                            "Category 1",
                            style: TextStyle(
                              fontSize: 12,
                              color: dark.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              // right part (amount and time)
              SizedBox(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: (size.width - 90) * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const Text(
                            "Rp20,000.00",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: secondary,
                            ),
                          ),
                          sbh4(),
                          Text(
                            "12:20",
                            style: TextStyle(
                              fontSize: 12,
                              color: dark.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          horisontalLine(),
        ],
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

  Widget horisontalLine() {
    return const Padding(
      padding: EdgeInsets.only(top: 8),
      child: Divider(
        thickness: 0.8,
      ),
    );
  }
}