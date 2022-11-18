import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';

Widget yearPicker(String selectedYear, BuildContext context) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      selectedYear,
      style: const TextStyle(
        color: white,
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

  Widget pickYear(DateTime now, DateTime pickedDate) {
    return AlertDialog(
      title: const Text("Select Year"),
      content: SizedBox( // Need to use container to add size constraint.
        width: 300,
        height: 300,
        child: YearPicker(
          firstDate: DateTime(now.year - 10, 1, 1),
          lastDate: DateTime(now.year + 10, 1, 1),
          initialDate: now,
          selectedDate: pickedDate,
          onChanged: (DateTime value) {
            setState(() {
              pickedDate = value.year;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }