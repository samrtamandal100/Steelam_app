import 'package:flutter/material.dart';
import 'package:steelam_industries_app/src/views/Admin/common_widgets/FileUpload.dart';
import 'package:steelam_industries_app/src/views/Admin/common_widgets/InputReuseableComponent.dart';
import 'package:steelam_industries_app/src/views/Admin/common_widgets/reuseableProfile.dart';
import 'package:steelam_industries_app/src/views/Admin/screens/AuthenticateScreen.dart';
import 'package:steelam_industries_app/src/views/Admin/screens/Setnewpassword.dart';
import 'package:steelam_industries_app/src/views/Admin/screens/forgotpassword.dart';
import 'package:steelam_industries_app/src/views/Admin/screens/login.dart';
import 'package:steelam_industries_app/src/views/Admin/screens/testing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StoreForm(),
    );
  }
}