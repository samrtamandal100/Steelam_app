import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters if needed
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:steelam_industries_app/src/controllers/forgotpasswordControllers.dart';

class Forgotpassword extends StatelessWidget {
  final Forgotpasswordcontrollers controller =
      Get.put(Forgotpasswordcontrollers());

  Forgotpassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.of(context).pop(), // Handle back navigation
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth >= 1200;
            return buildContent(context, isDesktop: isDesktop);
          },
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, {bool isDesktop = false}) {
    double imageSize = isDesktop ? 250 : 150;
    double padding = isDesktop ? 80 : 20;

    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Image.asset('assets/logo/logo.png', height: imageSize),
                SizedBox(height: 30),
                Text("Forgot Password",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Welcome Back! to Steelam Industries",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                SizedBox(height: 30),
                Image.asset('assets/image/forgotimage.png', height: imageSize),
                SizedBox(height: 30),
                SizedBox(
                  width:
                      400, // Fixed width, adjust as necessary for your design
                  child: TextFormField(
                    controller: controller.phoneController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person, color: Color(0xFFa0753a)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: controller.validatePhone,
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 400,
                  height: 40, // Fixed height for consistency
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState?.validate() == true) {
                        controller.trySubmit();
                        _forgotPassword(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFc89b6e),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    child: Text('Send'),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _forgotPassword(BuildContext context) {
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
}
