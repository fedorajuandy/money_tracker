import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:money_tracker/models/new_transaction.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/themes/text_formats.dart';
import 'package:money_tracker/models/report.dart';
import 'package:money_tracker/operations/transaction_operation.dart';
import 'package:money_tracker/widgets/title.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('transactions');
  final transactionOperation = TransactionOperation();
  final report = Report();
  DateTime now = DateTime.now();
  // current month
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
      falMonthly();
      falYearly();
      setState(() {
        report.setHighestExpense(report.getHighestExpense());
        report.setHighestIncome(report.getHighestIncome());
        report.setLowestExpense(report.getLowestExpense());
        report.setLowestIncome(report.getLowestIncome());
        report.setMonthlyExpense(report.getMonthlyExpense());
        report.setMontlyIncome(report.getMonthlyIncome());
        report.setYearlyExpense(report.getYearlyIncome());
      });
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
                    title("Reports"),
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
                falMonthly(),
                monthly(report.getMonthlyExpense(), report.getMonthlyIncome()),
                sbh24(),
                falYearly(),
                yearly(report.getYearlyExpense(), report.getYearlyIncome(), report.getHighestExpense(), report.getHighestIncome(), report.getLowestExpense(), report.getLowestIncome()),
                sbh40(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget falMonthly() {
    report.resetMonthlyExpense();
    report.resetMonthlyIncome();

    return FirebaseAnimatedList(
      query: transactionOperation.getQuery(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final transaction = NewTransaction.fromJson(json);
        String dd = transaction.getDate();

        if(dd.substring(0, 4) == _selectedYear.toString() && dd.substring(5, 7) == (_selectedIndex + 1).toString()) {
          int type = transaction.getType();
          double amount = transaction.getAmount();

          if(type == 0) {
            report.addMonthlyIncome(amount);
          } else {
            report.addMonthlyExpense(amount);
          }
        }

        // NOT YET
        return Container();
      },
      physics: const ScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget falYearly() {
    report.resetHighestExpense();
    report.resetHighestIncome();
    report.resetLowestExpense();
    report.resetLowestIncome();
    report.resetYearlyExpense();
    report.resetYearlyIncome();

    return FirebaseAnimatedList(
      query: transactionOperation.getQuery(),
      itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final transaction = NewTransaction.fromJson(json);
        String dd = transaction.getDate();

        if(dd.substring(0, 4) == _selectedYear.toString()) {
          int type = transaction.getType();
          double amount = transaction.getAmount();
          double lowestExpense = 0;
          double highestExpense = 0;
          double lowestIncome = 0;
          double highestIncome = 0;

          if(index == 0) {
            lowestExpense = amount;
            highestExpense = amount;
            lowestIncome = amount;
            highestIncome = amount;
          } else {
            if(type == 0) {
              if(amount < lowestIncome) lowestIncome = amount;
              if(amount > highestIncome) highestIncome = amount;
            } else {
              if(amount < lowestExpense) lowestExpense = amount;
              if(amount > highestExpense) highestExpense = amount;
            }
          }
        }

        // NOT YET
        return Container();
      },
      physics: const ScrollPhysics(),
      shrinkWrap: true,
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

  Widget yearly(double yearlyExpense, double yearlyIncome, double highestExpense, double highestIncome, double lowestExpense, double lowestIncome) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 280,
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
                    sbh12(),
                    yearlyTextPositive("Income", CurrencyFormat.convertToIdr(yearlyIncome, 2)),
                    sbh8(),
                    yearlyTextNegative("Expenses", CurrencyFormat.convertToIdr(yearlyExpense, 2)),
                    sbh8(),
                    yearlyTextPositive("Highest income", CurrencyFormat.convertToIdr(highestIncome, 2)),
                    sbh8(),
                    yearlyTextNegative("Lowest income", CurrencyFormat.convertToIdr(lowestIncome, 2)),
                    sbh8(),
                    yearlyTextPositive("Lowest expense", CurrencyFormat.convertToIdr(lowestExpense, 2)),
                    sbh8(),
                    yearlyTextNegative("Highest expense", CurrencyFormat.convertToIdr(highestExpense, 2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget yearlyTextPositive(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text(
            title,
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
              amount,
              style: const TextStyle(
                fontSize: 16,
                color: secondary,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget yearlyTextNegative(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Text(
            title,
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
              amount,
              style: const TextStyle(
                fontSize: 16,
                color: redSecondary,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget monthly(double monthlyExpense, double monthlyIncome) {
    var size = MediaQuery.of(context).size;

    return Wrap(
      spacing: 20,
      children: <Widget>[
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
            padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: red,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.keyboard_double_arrow_left,
                      color: Colors.white,
                    ),
                  ),
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
                    Text(
                      CurrencyFormat.convertToIdr(monthlyExpense, 2),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.keyboard_double_arrow_right,
                      color: Colors.white,
                    ),
                  ),
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
                    Text(
                      CurrencyFormat.convertToIdr(monthlyIncome, 2),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
}
