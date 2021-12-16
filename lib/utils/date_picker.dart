import 'package:firebase_authentication/data/theme/date_picker_theme.dart';
import 'package:flutter/material.dart';

class DatePicker {
  static Future<dynamic> pickDate({
    BuildContext context,
    DateTime currentDate,
    DateTime firstDate,
  }) async {
    final DateTime picked = await showDatePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: DatePickerTheme.datePicker,
          child: child,
        );
      },
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
    );
    return picked;
  }
}
