import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:money_tracker/controllers/transaction_operation.dart';
import 'package:firebase_database/firebase_database.dart';

class BalanceAddTransactionScreen extends StatefulWidget {
  const BalanceAddTransactionScreen({super.key});

  @override
  State<BalanceAddTransactionScreen> createState() => _BalanceAddTransactionScreenState();
}

class _BalanceAddTransactionScreenState extends State<BalanceAddTransactionScreen> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _nameText = TextEditingController();
  final TextEditingController _amountText = TextEditingController();
  String nameText = "Name";
  String amountText = "10000";
  DateTime added = DateTime.now();
  String? categoryText = "Uncategorised";
  late DatabaseReference dbRef;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: const Text(
          'Add new transaction',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 4,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _keyform,
          child: ListView(
            children: <Widget>[
              textFieldName(),
              separator(),
              dropdownCategory(),
              separator(),
              textFieldAmount(),
              separator(),
              separator(),
              buttonAdd(),
            ],
          ),
        ),
      )
    );
  }

  Widget separator() {
    return const SizedBox(height: 20);
  }

  Widget textFieldName() {
    return TextFormField(
      cursorColor: Colors.white54,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: "Title",
        hintStyle: TextStyle(
          color: Colors.white24,
        ),
        labelText: 'Title',
        labelStyle: TextStyle(
          color: Colors.white54,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white54,
          ),
        ),
      ),
      controller: _nameText,
      validator: (value) {
        return (value !.isEmpty? "Please input title": null);
      },
      onChanged: (String value) {
        setState(() {
          nameText = value;
        });
      },
    );
  }

  Widget textFieldAmount() {
    return TextFormField(
      cursorColor: Colors.white54,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: "Description",
        hintStyle: TextStyle(
          color: Colors.white24,
        ),
        labelText: 'Description',
        labelStyle: TextStyle(
          color: Colors.white54,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white54,
          ),
        ),
      ),
      controller: _amountText,
      validator: (value) {
        return (value !.isEmpty? "Please input description": null);
      },
      onChanged: (String value) {
        setState(() {
          amountText = value;
        });
      },
    );
  }

  Widget buttonAdd() {
    return TextButton(
      onPressed: () {
        Provider.of<TransactionOperation>(context, listen: false).addNewTransaction(nameText, categoryText, DateTime.now(), amountText);
        return Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      child: const Text("Add Transaction"),
    );
  }

  Widget dropdownCategory() {
    return DropdownButtonFormField <String>(
      decoration: const InputDecoration(
        hintText: "Choose location",
        hintStyle: TextStyle(
          color: Colors.white24,
        ),
        labelText: 'Choose location',
        labelStyle: TextStyle(
          color: Colors.white54,
        ),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white54,
          ),
        ),
      ),
      items: <String>[
        "A", "B", "C"
      ].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          categoryText = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return "Please choose a location";
        } else {
          return null;
        }
      },
    );
  }
}
