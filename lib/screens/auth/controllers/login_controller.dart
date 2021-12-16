import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  TextEditingController emailController;
  TextEditingController passwordContoller;

  final GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordContoller = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordContoller.dispose();
    super.onClose();
  }
}
