import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:steelam_industries_app/src/controllers/admin/forgotpasswordControllers.dart';

void _forgotPassword(BuildContext context) {
  final Forgotpasswordcontrollers controller =
      Get.put(Forgotpasswordcontrollers());
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Forgot Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Please enter the OTP sent to your phone number.'),
          SizedBox(height: 10),
          SizedBox(
            width: 400, // Fixed width for the forgot password field
            child: Pinput(
              length: 6, // Length of the OTP
              controller: controller.phoneController1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              focusedPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFa0753a)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFc89b6e)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                return controller.validatePhone1(value);
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Send'),
          onPressed: () {
            if (controller.formKey.currentState?.validate() == true) {
              controller.trySubmit1();
              Navigator.of(ctx).pop();
            }
          },
        ),
        TextButton(
          child: Text('Close'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}
