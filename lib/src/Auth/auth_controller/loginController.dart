import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steelam_industries_app/src/Auth/auth_screen/login.dart';
import 'package:steelam_industries_app/src/GlobalController/snackbar.dart';

import '../auth_screen/destroye_session.dart';

class LoginController extends GetxController {
  final SnackbarsController snackbarController =
      Get.find<SnackbarsController>();
  var username = ''.obs;
  var password = ''.obs;
  var destroyeusername = ''.obs;
  var destroyepassword = ''.obs;
  var isPasswordVisible = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  final Uri url = Uri.parse('http://127.0.0.1:8000/api/destroy-sessions');

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

// destroy session input field password togglers
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // this one is work destroy session
  void destroyPreviousSession() async {
    try {
      final response = await http.post(
        url,
        body: {
          'username': destroyeusername.value,
          'password': destroyepassword.value,
        },
      );

      final responseData = json.decode(response.body);

      if (responseData['code'] == 4700) {
        // Successfully logged out

        snackbarController
            .showSuccessSnackbar(" Successfully logged out all devices - 4700");
        Get.offAll(() => LoginPage());
      } else if (responseData['code'] == 4701) {
        // Invalid username or password
        snackbarController
            .showWarningSnackbar("Invalid Username and Password - 4701 ");
      } else if (responseData['code'] == 4713) {
        // Error
        snackbarController.showErrorSnackbar("Error 4713");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

// this one is popup dialog box
  void showWarningPopup() {
    try {
      Get.dialog(
        WarningPopup(sessionController: this),
        barrierDismissible: false,
      );
    } catch (e) {
      print('Error displaying dialog: $e');
    }
  }

  // this one is login user
  Future<void> login(String username, String password) async {
    try {
      final response = await postRequest('/login', {
        'username': username,
        'password': password,
      });

      if (response['code'] == 4700) {
        // final code = response['code'];
        final data = response['data'];
        final token = data['token'];
        final userInfo = data['userInfo'];
        await _saveToken(token);
        await _saveUserInfo(userInfo);
        snackbarController.showSuccessSnackbar("Login successfully");
      } else if (response['code'] == 4702) {
        showWarningPopup();
      } else {
        throw Exception('Token not found in response');
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

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfoString = prefs.getString('user_info');
    if (userInfoString != null) {
      return jsonDecode(userInfoString);
    }
    return null;
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
      // Perform login action
      formKey.currentState?.save();
      await login(username.value, password.value);
    }
  }
}
