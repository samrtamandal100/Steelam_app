// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyHomePage(),
    );
  }
}

class UserController extends GetxController {
  var email = ''.obs;
  var phoneNumber = ''.obs;

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber.value = newPhoneNumber;
  }
}

class MyHomePage extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reusable Text Field with GetX'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            ReusableTextField(
              label: 'Email Address',
              hintText: 'Enter your email',
              onChanged: userController.updateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ReusableTextField(
              label: 'Phone Number',
              hintText: 'Enter your phone number',
              onChanged: userController.updatePhoneNumber,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            Obx(() => Text('Email: ${userController.email}')),
            Obx(() => Text('Phone: ${userController.phoneNumber}')),
          ],
        ),
      ),
    );
  }
}

class ReusableTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Function(String) onChanged;
  final TextInputType keyboardType;

  const ReusableTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
