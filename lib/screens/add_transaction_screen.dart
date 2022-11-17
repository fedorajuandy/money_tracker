import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:money_tracker/controllers/transaction_operation.dart';
import 'package:firebase_database/firebase_database.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _nameText = TextEditingController();
  final TextEditingController _amountText = TextEditingController();
  late DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('transactions');
  String? categoryText = "Other";
  List<String> categories = <String>['Sales', 'Income', "Food and beverages", 'Other'];

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
      cursorColor: primary,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintText: "Title",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Title',
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
          'category': categoryText.toString(),
          'added': DateTime.now().toString(),
          'amount': _amountText.text,
        };

        dbRef.push().set(transaction);
        Provider.of<TransactionOperation>(context, listen: false).addNewTransaction(_nameText.text, categoryText, double.parse(_amountText.text), DateTime.now());
        return Navigator.pop(context);
      },
      style: TextButton.styleFrom(
        backgroundColor: secondary,
        foregroundColor: Colors.black87,
      ),
      child: const Text("Add rransaction"),
    );
  }

  Widget dropdownCategory() {
    return DropdownButtonFormField <String>(
      decoration: const InputDecoration(
        hintText: "Choose category",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'Choose category',
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
      items: categories.map((String value) {
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
          return "Please choose a category";
        } else {
          return null;
        }
      },
    );
  }
}
