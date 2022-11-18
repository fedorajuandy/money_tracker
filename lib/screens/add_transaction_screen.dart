import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/widgets/title.dart';
import 'package:money_tracker/controllers/transaction_operation.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _nameText = TextEditingController();
  final TextEditingController _typeText = TextEditingController();
  final TextEditingController _categoryText = TextEditingController();
  final TextEditingController _amountText = TextEditingController();
  late DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('transactions');

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
              padding: const EdgeInsets.only(top: 24, bottom: 24, right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  title("Add transaction"),
                ],
              ),
            ),
          ),
          sbh32(),
          Container(
            padding:const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keyform,
              child: Column(
                children: <Widget>[
                  textFieldName(),
                  sbh20(),
                  chooseType(),
                  sbh20(),
                  textFieldCategory(),
                  sbh20(),
                  textFieldAmount(),
                  sbh32(),
                  buttonAdd(),
                  sbh40(),
                ],
              ),
            ),
          ),
        ],
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
        labelText: "Transaction name",
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

  Widget chooseType() {
    return Text("F");
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
      controller: _nameText,
      validator: (value) {
        return (value !.isEmpty? "Please input transaction category": null);
      },
    );
  }

  Widget textFieldAmount() {
    return TextFormField(
      cursorColor: primary,
      style: const TextStyle(color: secondary),
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

  Widget buttonAdd() {
    return TextButton(
      onPressed: () {
        Map<String, String> transaction = {
          'name': _nameText.text,
          'category': _categoryText.text,
          'added': DateTime.now().toString(),
          'amount': _amountText.text,
        };

        dbRef.push().set(transaction);
        Provider.of<TransactionOperation>(context, listen: false).addNewTransaction(_nameText.text, _typeText.text, _categoryText.text, double.parse(_amountText.text), DateTime.now());
        return Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: Colors.black87,
      ),
      child: const Text("Add rransaction"),
    );
  }
}