import 'package:flutter/material.dart';
import 'package:get/get.dart';

class newpasswordController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateUsername(String value) {
    if (value.isEmpty) {
      return "Please enter your username";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  void trySubmit() {
    if (formKey.currentState?.validate() ?? false) {
      // Perform login action
      // Perform login action
      print("Login successful! ${username.value} ${password.value}");
    }
  }
}
