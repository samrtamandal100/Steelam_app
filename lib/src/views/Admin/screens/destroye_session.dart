import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void destroyPreviousSession() {
    // Implement your logic to destroy the previous session
    print('Username: ${username.value}');
    print('Password: ${password.value}');
    // Perform necessary actions to destroy the session
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Destroy Session Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  final SessionController sessionController = Get.put(SessionController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.dialog(WarningPopup(
              sessionController: sessionController,
            ));
          },
          child: Text('Show Destroy Session Popup'),
        ),
      ),
    );
  }
}

class DestroySessionPopup extends StatelessWidget {
  final dynamic sessionController;
  DestroySessionPopup({required this.sessionController});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 400, // Fixed width
        height: 300, // Fixed height
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Destroy Your All Session',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => sessionController.username.value = value,
              decoration: InputDecoration(
                labelText: 'Enter your user name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(() => TextField(
                  onChanged: (value) =>
                      sessionController.password.value = value,
                  obscureText: !sessionController.isPasswordVisible.value,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(sessionController.isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: sessionController.togglePasswordVisibility,
                    ),
                  ),
                )),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sessionController.destroyPreviousSession,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.brown, // Change the color to match your design
              ),
              child: Text('Destroy Previous Session'),
            ),
          ],
        ),
      ),
    );
  }
}

class WarningPopup extends StatelessWidget {
  final dynamic sessionController;

  WarningPopup({required this.sessionController});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 400, // Fixed width
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Colors.amber,
              size: 50,
            ),
            SizedBox(height: 20),
            Text(
              'Already Login in another device',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color(0xFFa0753a)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: sessionController.destroyPreviousSession,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFa0753a),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ) // Change the color to match your design
                      ),
                  child: Text(
                    'Destroy Session',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
