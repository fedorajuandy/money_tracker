import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:money_tracker/screens/update_transaction_screen.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/currency_format.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/widgets/title.dart';
import 'package:table_calendar/table_calendar.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  Query dbRef = FirebaseDatabase.instance.ref().child('transactions');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('transactions');
  /* Map<dynamic, dynamic> transactions = dbRef.data.value;
    transactions.forEach((key, transactions) {
      needs.add(Need.fromSnapshot(transactions));
  }); */
  final currFormat = NumberFormat("#,##0.00", "en_US");
  // today's date
  int selectedIndex = DateTime.now().day - 1;
  DateTime now = DateTime.now();
  // late = when runtime, not when initialised
  late DateTime lastDayOfMonth;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime? _selectedDay;

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
    return Column(
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
            padding: const EdgeInsets.only(top: 60, bottom: 24, right: 20, left: 20),
            child: Column(
              children: <Widget>[
                title("Transactions"),
                Column(
                  children: <Widget>[
                    tableCalendar(),
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
                FirebaseAnimatedList(
                  query: dbRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    Map transaction = snapshot.value as Map;
                    transaction['key'] = snapshot.key;
                    return transactionList(transaction: transaction);
                  },
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                ),
                sbh16(),
                total(),
              ],
            ),
          ),
        ),
        sbh40(),
      ],
    );
  }

  Widget tableCalendar() {
    return TableCalendar(
      firstDay: DateTime(2010, 1, 1),
      focusedDay: now,
      lastDay: lastDayOfMonth,
      calendarFormat: _calendarFormat,
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: secondary,
          shape: BoxShape.circle,
          border: Border.all(
            color: secondary,
          ),
        ),
        todayDecoration: BoxDecoration(
          color: primary,
          shape: BoxShape.circle,
          border: Border.all(
            color: primary,
          ),
        ),
        weekendTextStyle: const TextStyle(
          color: red,
        ),
      ),
      // selecting a date
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          now = focusedDay;
        });
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        now = focusedDay;
      },
    );
  }

  Widget transactionList({required Map transaction}) {
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
                          Text(
                            transaction['name'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: dark,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          sbh4(),
                          Text(
                            transaction['category'],
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
                      width: (size.width - 120) * 0.5,
                      child: SizedBox(
                        width: (size.width - 120) * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              CurrencyFormat.convertToIdr(int.parse(transaction['amount']), 2),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: transaction['type'] == "1" ? red1 : secondary,
                              ),
                            ),
                            sbh4(),
                            Text(
                              transaction['added'].substring(11, 16),
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
                    ),
                  ],
                ),
              ),
              sbw8(),
              // for edit and delete
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateTransactionScreen(transactionKey: transaction['key'])));
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
                        reference.child(transaction['key']).remove();
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
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              // CurrencyFormat.convertToIdr(getTotal(transaction: transaction), 2),
              "YOLO",
              style: const TextStyle(
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

  double getTotal({required Map transaction}) {
    double sum = 0;

    for(int i = 0; i < transaction.length; i++){
      sum += transaction['amount'][i];
    }

    return sum;
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