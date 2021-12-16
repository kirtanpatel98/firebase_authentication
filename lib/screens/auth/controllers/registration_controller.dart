import 'package:firebase_authentication/data/constants/size_constants.dart';
import 'package:firebase_authentication/utils/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  RxString selectedDate = RxString("");
  void pickDate({
    @required BuildContext context,
    @required DateTime firstDate,
    @required TextEditingController textController,
  }) async {
    try {
      var currentDate = DateTime.now();
      selectedDate.value = "";
      var pickedDate = await DatePicker.pickDate(
        context: context,
        currentDate: currentDate,
        firstDate: firstDate,
      );
      if (pickedDate != null && pickedDate != currentDate) {
        currentDate = pickedDate;
        var format = DateConstant.dateFormat;
        selectedDate.value = format.format(currentDate);
        textController.text = selectedDate.value;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
