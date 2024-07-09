import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Forgotpasswordcontrollers extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  final phoneController1 = TextEditingController();

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  String? validatePhone1(String? value) {
    if (value == null || value.isEmpty || value.length != 6) {
      return 'Please enter a valid 6-digit OTP';
    }
    return null;
  }

  void trySubmit1() {
    if (validatePhone(phoneController.text) == null) {
      // Assuming this method sends the OTP for verification
      print("OTP Verified! :${phoneController.text}");
    } else {
      print("Invalid OTP");
    }
  }

  void trySubmit() {
    try {
      if (formKey.currentState!.validate()) {
        // Temporarily remove Get.snackbar and other logic
        print(
            "Login attempt successful with phone number: ${phoneController.text}");
      } else {
        print("Form validation failed");
      }
      print('Phone Number Entered: ${phoneController.text}');
    } catch (e, stackTrace) {
      print('An error occurred: $e');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  void onClose() {
    // Dispose the controller when the GetX controller is removed from memory
    phoneController.dispose();
    super.onClose();
  }
}
