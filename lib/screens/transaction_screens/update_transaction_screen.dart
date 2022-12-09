import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
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
  DateTime now = DateTime.now();
  int _prevType = 0;
  late int activeType = 0;
  late DatabaseReference dbTransaction;
  late DatabaseReference dbBalance;
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
    Map balance = snapshot.value as Map;
    _amount = balance['amount'];
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
              padding: const EdgeInsets.only(top: 60, bottom: 24, right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  title("Add transaction"),
                ],
              ),
            ),
          ),
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
                  textFieldName(),
                  sbh20(),
                  textFieldCategory(),
                  sbh20(),
                  textFieldAmount(),
                  sbh20(),
                  pickDate(),
                  sbh20(),
                  pickTime(),
                  sbh32(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buttonCancel(),
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
              color: activeType == 0 ? primary : Colors.transparent
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
              color: activeType == 1 ? red : Colors.transparent
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

  Widget textFieldName() {
    return TextFormField(
      cursorColor: primary,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintText: "Transaction name",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Transaction name',
        labelStyle: TextStyle(
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      controller: _nameText,
      validator: (value) {
        return (value !.isEmpty? "Please input transaction name": null);
      },
    );
  }

  Widget textFieldCategory() {
    return TextFormField(
      cursorColor: primary,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintText: "Category",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: "Category",
        labelStyle: TextStyle(
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      controller: _categoryText,
      validator: (value) {
        return (value !.isEmpty? "Please input transaction category": null);
      },
    );
  }

  Widget textFieldAmount() {
    return TextFormField(
      cursorColor: primary,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintText: "Amount",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Amount',
        labelStyle: TextStyle(
          color: primary,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primary,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      controller: _amountText,
      validator: (value) {
        return (value !.isEmpty? "Please input transaction amount": null);
      },
    );
  }

  Widget pickDate() {
    return TextFormField(
      controller: _dateText,
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
          initialDate: now,
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
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
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
        double currAmount = double.parse(_amountText.text);
        Map<String, dynamic> transaction = {
          'type': activeType,
          'name': _nameText.text,
          'category': _categoryText.text,
          'amount': currAmount,
          'date': _dateText.text,
          'time': _timeText.text,
        };

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

        Map<String, dynamic> balance = {
          'amount': _amount += addAmount,
        };

        dbTransaction.child(widget.transactionKey).update(transaction);
        dbBalance.child("user0").update(balance).then((value) => {
          Navigator.pop(context),
        });
      },
      child: const Text("Update transaction"),
    );
  }

  Widget buttonCancel() {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: white,
        foregroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(
            color: primary,
          ),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Cancel"),
    );
  }
}