// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import '../views/Admin/screens/destroye_session.dart';

// class LoginController extends GetxController {
//   var username = ''.obs;
//   var password = ''.obs;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   static const String baseUrl = 'http://127.0.0.1:8000/api';

//   static Future<Map<String, dynamic>> postRequest(
//       String endpoint, Map<String, dynamic> data) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl$endpoint'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(data),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }

//   Future<void> login(String username, String password) async {
//     try {
//       final response = await postRequest('/login', {
//         'username': username,
//         'password': password,
//       });

//       if (response['code'] == 4700) {
//         final code = response['code'];
//         final data = response['data'];
//         final token = data['token'];
//         final userInfo = data['userInfo'];

//         await _saveToken(token);
//         await _saveUserInfo(userInfo);
//       } else if (response['code'] == 4702) {
//         print(response);
//         Get.dialog(
//             WarningPopup(sessionController: Get.find<SessionController>()));
//       } else {
//         throw Exception('Token not found in response');
//       }
//       // print(response['code ']);
//       // Get.snackbar('success', response.success);
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     }
//   }

//   Future<void> _saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('auth_token', token);
//   }

//   Future<void> _saveUserInfo(Map<String, dynamic> userInfo) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('user_info', jsonEncode(userInfo));
//   }

//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('auth_token');
//   }

//   Future<Map<String, dynamic>?> getUserInfo() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userInfoString = prefs.getString('user_info');
//     if (userInfoString != null) {
//       return jsonDecode(userInfoString);
//     }
//     return null;
//   }

//   String? validateUsername(String value) {
//     if (value.isEmpty) {
//       return "Please enter your username";
//     }
//     return null;
//   }

//   String? validatePassword(String value) {
//     if (value.length < 6) {
//       return "Password must be at least 6 characters";
//     }
//     return null;
//   }

//   Future<void> trySubmit() async {
//     if (formKey.currentState?.validate() ?? false) {
//       // Perform login action
//       formKey.currentState?.save();
//       await login(username.value, password.value);
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../views/Admin/screens/destroye_session.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  static Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<void> login(String username, String password) async {
    try {
      final response = await postRequest('/login', {
        'username': username,
        'password': password,
      });

      if (response['code'] == 4700) {
        final data = response['data'];
        final token = data['token'];
        final userInfo = data['userInfo'];

        await _saveToken(token);
        await _saveUserInfo(userInfo);
        Get.snackbar('Success', 'Logged in successfully');
      } else if (response['code'] == 4702) {
        print('Response Code 4702: ${response}');

        Get.dialog(WarningPopup(
          sessionController: this,
        ));
      } else {
        throw Exception('Login failed with code: ${response['code']}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> _saveUserInfo(Map<String, dynamic> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_info', jsonEncode(userInfo));
  }

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

  Future<void> trySubmit() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      await login(username.value, password.value);
    }
  }
}
