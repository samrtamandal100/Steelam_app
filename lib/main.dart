import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:steelam_industries_app/src/GlobalController/snackbar.dart';
import 'package:steelam_industries_app/src/views/Admin/common_widgets/FileUpload.dart';
import 'package:steelam_industries_app/src/views/Admin/common_widgets/InputReuseableComponent.dart';
import 'package:steelam_industries_app/src/views/Admin/common_widgets/reuseableProfile.dart';
import 'package:steelam_industries_app/src/Auth/auth_screen/AuthenticateScreen.dart';
import 'package:steelam_industries_app/src/Auth/auth_screen/Setnewpassword.dart';
import 'package:steelam_industries_app/src/Auth/auth_screen/forgotpassword.dart';
import 'package:steelam_industries_app/src/Auth/auth_screen/login.dart';
import 'package:steelam_industries_app/src/views/Admin/screens/testing.dart';

import 'src/Auth/auth_controller/loginController.dart';
import 'src/Auth/auth_screen/destroye_session.dart';

void main() {
  Get.lazyPut(() => SnackbarsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
