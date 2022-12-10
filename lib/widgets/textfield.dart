import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';

Widget textField(String tfName, TextEditingController tfController, String tfValidText) {
  return TextFormField(
    cursorColor: primary,
    style: const TextStyle(color: dark),
    decoration: InputDecoration(
      hintText: tfName,
      hintStyle: const TextStyle(
        color: Colors.black54,
      ),
      labelText: tfName,
      labelStyle: const TextStyle(
        color: primary,
      ),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: primary,
        ),
      ),
    ),
    controller: tfController,
    validator: (value) {
      return (value !.isEmpty? tfValidText : null);
    },
  );
}

Widget textFieldNumber(String tfName, TextEditingController tfController, String tfValidText) {
  return TextFormField(
    cursorColor: primary,
    style: const TextStyle(color: dark),
    decoration: InputDecoration(
      hintText: tfName,
      hintStyle: const TextStyle(
        color: Colors.black54,
      ),
      labelText: tfName,
      labelStyle: const TextStyle(
        color: primary,
      ),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: primary,
        ),
      ),
    ),
    keyboardType: TextInputType.number,
    controller: tfController,
    validator: (value) {
      return (value !.isEmpty? tfValidText : null);
    },
  );
}
