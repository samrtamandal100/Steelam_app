import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  void validatePin(String pin) {
    // Logic to validate pin
    print('Validating pin: $pin');
  }
}
