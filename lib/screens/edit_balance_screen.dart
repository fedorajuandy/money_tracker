import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';
import 'package:money_tracker/themes/spaces.dart';
import 'package:money_tracker/widgets/title.dart';

class EditBalanceScreen extends StatefulWidget {
  const EditBalanceScreen({super.key});

  @override
  State<EditBalanceScreen> createState() => _EditBalanceScreenState();
}

class _EditBalanceScreenState extends State<EditBalanceScreen> {
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  final TextEditingController _balanceText = TextEditingController();
  
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
              padding: const EdgeInsets.only(top: 48, bottom: 24, right: 20, left: 20),
              child: Column(
                children: <Widget>[
                  title("Edit balance"),
                ],
              ),
            ),
          ),
          sbh32(),
          Padding(
            padding:const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _keyform,
              child: Column(
                children: <Widget>[
                  textFieldBalance(),
                  sbh32(),
                  buttonSave(),
                  sbh40(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget textFieldBalance() {
    return TextFormField(
      cursorColor: primary,
      style: const TextStyle(color: dark),
      decoration: const InputDecoration(
        hintText: "New balance",
        hintStyle: TextStyle(
          color: Colors.black54,
        ),
        labelText: 'New balance',
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
      controller: _balanceText,
      validator: (value) {
        return (value !.isEmpty? "Please input balance amount": null);
      },
    );
  }

  Widget buttonSave() {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        // Map<String, String> transaction = {
        //   'name': _nameText.text,
        //   'category': _categoryText.text,
        //   'added': DateTime.now().toString(),
        //   'amount': _amountText.text,
        // };

        // dbRef.push().set(transaction);
        // Provider.of<TransactionOperation>(context, listen: false).addNewTransaction(_nameText.text, _typeText.text, _categoryText.text, double.parse(_amountText.text), DateTime.now());
        return Navigator.pop(context);
      },
      child: const Text("Save"),
    );
  }
}