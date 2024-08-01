import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SessionController extends GetxController {
//   var destroyeusername = ''.obs;
//   var destroyepassword = ''.obs;
//   var isPasswordVisible = false.obs;
//   void togglePasswordVisibility() {
//     isPasswordVisible.value = !isPasswordVisible.value;
//   }

//   void destroyPreviousSession() {
//     // Implement your logic to destroy the previous session
//     print('Username: ${destroyeusername.value}');
//     print('Password: ${destroyepassword.value}');
//     // Perform necessary actions to destroy the session
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Destroy Session Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   final SessionController sessionController = Get.put(SessionController());
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Get.dialog(WarningPopup(
//               sessionController: sessionController,
//             ));
//           },
//           child: Text('Show Destroy Session Popup'),
//         ),
//       ),
//     );
//   }
// }
class DestroySessionPopup extends StatelessWidget {
  final dynamic sessionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DestroySessionPopup({required this.sessionController});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 400, // Fixed width
        height: 350, // Fixed height
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Destroy Your All Session',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) =>
                    sessionController.destroyeusername.value = value,
                decoration: InputDecoration(
                  labelText: 'Enter your user name',
                  border: OutlineInputBorder(),
                  focusColor: Color(0xFFa0753a),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFa0753a), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xFFa0753a), // Enabled border color
                      width: 1.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your user name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Obx(() => TextFormField(
                    onChanged: (value) =>
                        sessionController.destroyepassword.value = value,
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
                      focusColor: Color(0xFFa0753a),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Color(0xFFa0753a), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Color(0xFFa0753a), // Enabled border color
                          width: 1.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sessionController.destroyPreviousSession();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFa0753a),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10)) // Change the color to match your design
                    ),
                child: Text(
                  'Destroy Previous Session',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
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
        width: 400,
        height: 280, // Fixed width
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
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.dialog(DestroySessionPopup(
                      sessionController: sessionController,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFa0753a),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
