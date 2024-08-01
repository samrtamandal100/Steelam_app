import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:steelam_industries_app/src/Auth/auth_controller/AuthenticateScreenController.dart';
import 'package:steelam_industries_app/src/views/Admin/widgets/ContactInfo.dart';

class AuthenticationScreen extends StatelessWidget {
  final pinController = Get.put(PinController());

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
              return buildContent(context);
            }
          },
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context,
      {bool isMobile = false, bool isTablet = false}) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
            left: 30.0, right: 30.0, bottom: 30.0), // Removed top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/logo/logo.png', height: isMobile ? 150 : 250),
            Image.asset('assets/logo/group.png', height: isMobile ? 80 : 150),
            SizedBox(height: 60),
            Text(
              'Authenticate Your Account',
              style: TextStyle(
                fontSize: isMobile ? 18 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Security Pin is required',
              style: TextStyle(
                fontSize: isMobile ? 14 : 18,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Pinput(
              length: 6,
              controller: pinController.pinController,
              focusNode: pinController.focusNode,
              pinAnimationType: PinAnimationType.fade,
              defaultPinTheme: PinTheme(
                width: isMobile ? 40 : 60, // Adjust the width as needed
                height: isMobile ? 40 : 60, // Adjust the height as needed
                textStyle: TextStyle(fontSize: isMobile ? 20 : 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
              ),
              onCompleted: (pin) => pinController.validatePin(pin),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  pinController.validatePin(pinController.pinController.text),
              child: Text('Validate My Pin',
                  style: TextStyle(fontSize: isMobile ? 14 : 16)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFFA0A5B8), // Button background color
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Adjust the radius as needed
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                ContactInfo(
                  icon: FontAwesomeIcons.whatsapp,
                  text: '+91 89811 10827',
                  isMobile: isMobile,
                  iconColor: Color(0xFF25D366), // WhatsApp green
                ),
                SizedBox(height: 8),
                ContactInfo(
                  icon: Icons.email,
                  text: 'info@steelamindustries.com',
                  isMobile: isMobile,
                  iconColor: Colors.red, // Custom color for email icon
                ),
                SizedBox(height: 5),
                ContactInfo(
                  icon: Icons.web,
                  text: 'www.steelamindustries.com',
                  isMobile: isMobile,
                  iconColor: Colors.blue, // Blue color for web icon
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.facebook,
                  size: isMobile ? 20 : 24,
                  color: Color(0xFF1877F2), // Facebook's brand blue
                ),
                SizedBox(width: 10),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF833AB4), // Instagram gradient start
                        Color(0xFFF77737), // Instagram gradient middle
                        Color(0xFFE1306C), // Instagram gradient end
                        Color(0xFFC13584), // Instagram gradient end 2
                      ],
                    ).createShader(bounds);
                  },
                  child: Icon(
                    FontAwesomeIcons.instagram,
                    size: isMobile ? 20 : 24,
                    color: Colors.white, // Base color for gradient mask
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  FontAwesomeIcons.twitter,
                  size: isMobile ? 20 : 24,
                  color: Color(0xFF1DA1F2), // Twitter's brand blue
                ),
                SizedBox(width: 10),
                Icon(
                  FontAwesomeIcons.youtube,
                  size: isMobile ? 20 : 24,
                  color: Color(0xFFFF0000), // YouTube's brand red
                ),
              ],
            ),
            SizedBox(height: isMobile ? 20 : 40),
          ],
        ),
      ),
    );
  }
}
