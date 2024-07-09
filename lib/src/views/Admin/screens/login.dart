import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steelam_industries_app/src/controllers/admin/loginController.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  Widget buildContent(BuildContext context,
      {bool isMobile = false, bool isTablet = false}) {
    double imageSize = isMobile ? 150 : isTablet ? 200 : 250;
    double spaceHeight = isMobile ? 20 : isTablet ? 30 : 50;

    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : isTablet ? 40 : 60),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: spaceHeight),
                 SizedBox(height: spaceHeight),
                Image.asset('assets/logo/logo.png', height: imageSize),
                SizedBox(height: spaceHeight),
                Text("Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Welcome Back! to Steelam Industries",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                SizedBox(height: spaceHeight),
                Image.asset('assets/image/loginlogo.png', height: imageSize),
                SizedBox(height: spaceHeight),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color(0xFFa0753a),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color(0xFFc89b6e),
                          width: 1.0,
                        ),
                      ),
                    ),
                    validator: (value) =>
                        controller.validateUsername(value ?? ''),
                    onChanged: (value) => controller.username.value = value,
                  ),
                ),
                SizedBox(height: spaceHeight),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color(0xFFa0753a),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Color(0xFFc89b6e),
                          width: 1.0,
                        ),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) =>
                        controller.validatePassword(value ?? ''),
                    onChanged: (value) => controller.password.value = value,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xFFc89b6e)),
                    ),
                  ),
                ),
                SizedBox(height: spaceHeight),
                SizedBox(
                  width: 400,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => controller.trySubmit(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFc89b6e),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    child: Text('Continue'),
                  ),
                ),
                SizedBox(height: spaceHeight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              // Mobile layout
              return buildContent(context, isMobile: true);
            } else if (constraints.maxWidth < 1200) {
              // Tablet layout
              return buildContent(context, isTablet: true);
            } else {
              // Desktop layout
              return buildContent(context, isTablet: true);
            }
          },
        ),
      ),
    );
  }
}
