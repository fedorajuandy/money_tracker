import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyFormat {
    static String convertToIdr(dynamic number, int decimalDigit) {
      NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );

    return currencyFormatter.format(number);
  }
}

String formatDate(DateTime date) {
  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  return formattedDate;
}

String formatTime(TimeOfDay time) {
  String formattedTime = "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  return formattedTime;
}
