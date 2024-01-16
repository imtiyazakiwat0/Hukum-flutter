import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'GameHomePage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInWithPhoneNumberPage(),
    );
  }
}

class SignInWithPhoneNumberPage extends StatefulWidget {
  @override
  _SignInWithPhoneNumberPageState createState() =>
      _SignInWithPhoneNumberPageState();
}

class _SignInWithPhoneNumberPageState
    extends State<SignInWithPhoneNumberPage> {
  late String phoneNumber;
  late String verificationId;
  bool isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendOTP() async {
    setState(() {
      isLoading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          print('Verification Failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            isLoading = false;
            this.verificationId = verificationId;
          });

          // Navigate to OTP verification screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerifyOTPPage(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print('Error sending OTP: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In with Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                phoneNumber = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendOTP,
              child: isLoading
                  ? CircularProgressIndicator()
                  : Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyOTPPage extends StatefulWidget {
  final String verificationId;

  VerifyOTPPage({required this.verificationId});

  @override
  _VerifyOTPPageState createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> {
  late String otp;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      print('Verification Successful');
      // Redirect to GameHome after successful verification
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GameHomePage(),
        ),
      );
    } catch (e) {
      print('Error verifying OTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'OTP'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                otp = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
