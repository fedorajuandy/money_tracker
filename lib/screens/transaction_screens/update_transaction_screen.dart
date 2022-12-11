import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/models/balance.dart';
import 'package:money_tracker/models/new_transaction.dart';
import 'package:money_tracker/operations/balance_operation.dart';
import 'package:money_tracker/operations/transaction_operation.dart';
import 'package:money_tracker/widgets/button.dart';
import 'package:money_tracker/widgets/textfield.dart';
import 'package:money_tracker/widgets/title.dart';

class UpdateTransactionScreen extends StatefulWidget {
  const UpdateTransactionScreen({Key? key, required this.transactionKey}) : super(key: key);
  final String transactionKey;

  @override
  State<UpdateTransactionScreen> createState() => _UpdateTransactionScreenState();
}

class _UpdateTransactionScreenState extends State<UpdateTransactionScreen> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _nameText = TextEditingController();
  final TextEditingController _categoryText = TextEditingController();
  final TextEditingController _amountText = TextEditingController();
  final TextEditingController _dateText = TextEditingController();
  final TextEditingController _timeText = TextEditingController();
  late DatabaseReference dbTransaction;
  late DatabaseReference dbBalance;
  final transactionOperation = TransactionOperation();
  final balanceOperation = BalanceOperation();
  DateTime now = DateTime.now();
  int _prevType = 0;
  late int activeType = 0;
  double _prevAmount = 0;
  double _amount = 0;

  @override
  void initState() {
    super.initState();
    dbTransaction = FirebaseDatabase.instance.ref().child('transactions');
    dbBalance = FirebaseDatabase.instance.ref().child('balance');
    getTransactionData();
    getBalance();

    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        activeType = activeType;
      });
      chooseType();
    });
  }

  void getTransactionData() async {
    DataSnapshot snapshot = await dbTransaction.child(widget.transactionKey).get();
    Map transaction = snapshot.value as Map;

    _prevType = transaction['type'];
    activeType = transaction['type'];
    _nameText.text = transaction['name'];
    _categoryText.text = transaction['category'];
    _prevAmount = transaction['amount'];
    _amountText.text = transaction['amount'].toString();
    _dateText.text = transaction['date'];
    _timeText.text = transaction['time'];
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
                spreadRadius: 10,
                blurRadius: 3,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 24, right: 20, left: 20),
            child: Column(
              children: <Widget>[
                titleWithBack("Update transaction", context),
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
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    "Choose type",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: dark.withOpacity(0.5),
                    ),
                  ),
                ),
                sbh20(),
                chooseType(),
                sbh40(),
                Padding(
                  padding:const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _keyform,
                    child: Column(
                      children: <Widget>[
                        textField("Transaction name", _nameText, "Please input transaction name"),
                        sbh20(),
                        textField("Category", _categoryText, "Please input transaction category"),
                        sbh20(),
                        textFieldNumber("Amount" ,_amountText, "Please input transaction amount"),
                        sbh20(),
                        pickDate(),
                        sbh20(),
                        pickTime(),
                        sbh32(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            buttonCancel(context),
                            sbw8(),
                            buttonUpdate(),
                          ],
                        ),
                        sbh40(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget chooseType() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          typeIncome(),
          typeExpense(),
        ],
      ),
    );
  }

  Widget typeIncome() {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeType = 0;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          width: 150,
          height: 170,
          decoration: BoxDecoration(
            color: white,
            border: Border.all(
              width: 2,
              color: activeType == 0 ? primary : Colors.transparent,
            ),
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
                    color: primary,
                  ),
                ),
                const Text(
                  "Income",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget typeExpense() {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeType = 1;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          width: 150,
          height: 170,
          decoration: BoxDecoration(
            color: white,
            border: Border.all(
              width: 2,
              color: activeType == 1 ? red : Colors.transparent,
            ),
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
                    color: red,
                  ),
                ),
                const Text(
                  "Expense",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget pickDate() {
    return TextFormField(
      controller: _dateText,
      validator: (value) {
        return (value !.isEmpty? "Please input transaction date" : null);
      },
      readOnly: false,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Date',
        labelStyle: TextStyle(
          color: primary,
        ),
        suffixIcon: Icon(
          Icons.calendar_month,
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      cursorColor: primary,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.parse(_dateText.text),
          firstDate: DateTime(now.year - 10),
          lastDate: now,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: primary, // <-- SEE HERE
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            _dateText.text = formattedDate;
          });
        }
      },
    );
  }

  Widget pickTime() {
    return TextFormField(
      controller: _timeText,
      validator: (value) {
        return (value !.isEmpty? "Please input transaction time": null);
      },
      readOnly: false,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Time',
        labelStyle: TextStyle(
          color: primary,
        ),
        suffixIcon: Icon(
          Icons.access_time,
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      cursorColor: primary,
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour:int.parse(_timeText.text.split(":")[0]),minute: int.parse(_timeText.text.split(":")[1])),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: primary, // <-- SEE HERE
                ),
              ),
              child: child!,
            );
          },
        );

        if (pickedTime != null) {
          String formattedTime = "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
          setState(() {
            _timeText.text = formattedTime;
          });
        }
      },
    );
  }

  Widget buttonUpdate() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(20),
      ),
      onPressed: () {
        if (_keyform.currentState !.validate()) {
          double currAmount = double.parse(_amountText.text);
          final newTransaction = NewTransaction(activeType, _nameText.text, _categoryText.text, currAmount, _dateText.text, _timeText.text);
          transactionOperation.update(newTransaction, widget.transactionKey);

          double addAmount = 0;
          if(_prevType == 0) {
            if(activeType ==  0) {
              addAmount = currAmount - _prevAmount;
            } else {
              addAmount = 0 - currAmount - _prevAmount;
            }
          } else {
            if(activeType ==  0) {
              addAmount = _prevAmount + currAmount;
            } else {
              addAmount = _prevAmount - currAmount;
            }
          }
          final newBalance = Balance(_amount + addAmount);
          balanceOperation.update(newBalance);

          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please enter all required fields."),
            backgroundColor: primary,
          ));
        }
      },
      child: const Text("Update transaction"),
    );
  }
}
