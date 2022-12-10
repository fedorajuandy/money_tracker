import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';

Widget buttonCancel(dynamic context) {
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
