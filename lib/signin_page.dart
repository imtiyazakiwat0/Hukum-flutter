import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'SignInWithPhoneNumberPage.dart';
import 'SignInwithEmailandPassword.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/signinbackground2.jpg',
            fit: BoxFit.cover,
          ),
          // Sign In Options
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Adjust the height as needed
                Text(
                  'Sign In With',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 150), // Adjust the height as needed
                // buildSignInOption('Google', 'assets/google_icon.svg', () {
                //   // Handle Google sign-in
                // }),
                // buildSignInOption('Facebook', 'assets/facebook_icon.svg', () {
                //   // Handle Facebook sign-in
                // }),
                buildSignInOption('Mobile Number', 'assets/phone_icon.svg', () {
                  // Handle Mobile Number sign-in
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInWithPhoneNumberPage()),
                  );
                }),
                buildSignInOption('Email', 'assets/email_icon.svg', () {
                  // Navigate to the Email sign-in screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInWithEmailAndPassword()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInOption(String provider, String iconPath, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(340, 50), // Adjust the width and height as needed
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 32,
              height: 32,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                provider,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Your SignInScreen code remains the same as provided in the previous response

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(), // Set SignInPage as the home screen
    );
  }
}
