import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/text_formats.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/models/balance.dart';
import 'package:money_tracker/models/new_transaction.dart';
import 'package:money_tracker/models/report.dart';
import 'package:money_tracker/operations/balance_operation.dart';
import 'package:money_tracker/operations/transaction_operation.dart';
import 'package:money_tracker/screens/transaction_screens/update_transaction_screen.dart';
import 'package:money_tracker/widgets/title.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late DatabaseReference dbBalance;
  final transactionOperation = TransactionOperation();
  final balanceOperation = BalanceOperation();
  Report dailyReport = Report();
  DateTime _now = DateTime.now();
  int selectedIndex = DateTime.now().day - 1;
  // late = when runtime, not when initialised
  late DateTime _lastDayOfMonth;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime? _selectedDay = DateTime.now();
  double _sum = 0;
  double _total = 0;
  double _amount = 0;

  @override
  void initState() {
    super.initState();
    dbBalance = FirebaseDatabase.instance.ref().child('balance');
    getBalance();
    // get the next month, then take a step back to the last day (the last '0')
    _lastDayOfMonth = DateTime(_now.year, _now.month + 1, 0);

    WidgetsBinding.instance.addPostFrameCallback((_){
      fal();
      total();
    });
  }

  void getBalance() async {
    DataSnapshot snapshot = await dbBalance.child("user0").get();
    final json = snapshot.value as Map<dynamic, dynamic>;
    final balance = Balance.fromJson(json);
    _amount = balance.getAmount();
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
                Column(
                  children: <Widget>[
                    tableCalendar(),
                  ],
                ),
                sbh32(),
                fal(),
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

  Widget fal() {
    return FirebaseAnimatedList(
      query: transactionOperation.getQuery(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final transaction = NewTransaction.fromJson(json);

          if (transaction.getDate() == _selectedDay.toString().substring(0, 10)) {
            updateTotal(transaction.getType(), transaction.getAmount());
            return transactionList(snapshot.key, transaction.getType(), transaction.getName(), transaction.getCategory(), transaction.getAmount(), transaction.getDate(), transaction.getTime());
          } else {
            return Container();
          }
      },
      physics: const ScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget tableCalendar() {
    return TableCalendar(
      firstDay: DateTime(2010, 1, 1),
      focusedDay: _now,
      lastDay: _lastDayOfMonth,
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
          _now = focusedDay;
          _total = _sum;
          _total = _total;
          resetTotal();
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
        _now = focusedDay;
      },
    );
  }

  Widget transactionList(String? key, int type, String name, String category, double amount, String date, String time) {
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
                            name,
                            style: const TextStyle(
                              fontSize: 14,
                              color: dark,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          sbh4(),
                          Text(
                            category,
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
                              CurrencyFormat.convertToIdr(amount, 2),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: type == 1 ? redSecondary : secondary,
                              ),
                            ),
                            sbh4(),
                            Text(
                              time,
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
              // actions (edit and delete)
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // edit
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateTransactionScreen(transactionKey: key ?? "")));
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

                                    if(type == 0) {
                                      _amount -= amount;
                                    } else {
                                      _amount += amount;
                                    }

                                    final newBalance = Balance(_amount);
                                    balanceOperation.update(newBalance);

                                    transactionOperation.delete(key);
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
          horisontalLine(),
        ],
      ),
    );
  }

  Widget total() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 84),
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
              CurrencyFormat.convertToIdr(_total, 2),
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

  Widget horisontalLine() {
    return const Padding(
      padding: EdgeInsets.only(top: 4, bottom: 4),
      child: Divider(
        thickness: 0.8,
      ),
    );
  }

  void resetTotal() {
    _sum = 0;
  }
  void updateTotal(int type, double a) {
    if (type == 0) {
      _sum += a;
    } else {
      _sum -= a;
    }
  }
}