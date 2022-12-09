import 'package:flutter/material.dart';
import 'package:money_tracker/themes/colors.dart';

Widget title(String titleText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Text(
        titleText,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: dark,
        ),
      ),
    ],
  );
}

Widget titleWithBack(String titleText, dynamic context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: const <Widget>[
            Icon(
              Icons.arrow_back,
              color: primary,
            ),
          ],
        ),
      ),
      Text(
        titleText,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: dark,
        ),
      ),
    ],
  );
}