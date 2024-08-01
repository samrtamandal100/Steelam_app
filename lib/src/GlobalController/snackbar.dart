import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SnackbarsController extends GetxController {
  void showSuccessSnackbar(String message) {
    Get.snackbar(
      '',
      '',
      titleText: const Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 8),
          Text('Success',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),

      messageText: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      margin: const EdgeInsets.all(10),
      // icon: const Icon(Icons.close, color: Colors.white),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(Icons.close, color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      '',
      '',
      titleText: const Row(
        children: [
          Icon(Icons.error, color: Colors.white),
          SizedBox(width: 8),
          Text('Error, Something Worng',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.close, color: Colors.white),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(Icons.close, color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }

  void showWarningSnackbar(String message) {
    Get.snackbar(
      '',
      '',
      titleText: const Row(
        children: [
          Icon(Icons.warning, color: Colors.white),
          SizedBox(width: 8),
          Text('Warning',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      margin: const EdgeInsets.all(10),
      icon: const Icon(Icons.close, color: Colors.white),
      mainButton: TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(Icons.close, color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }
}
