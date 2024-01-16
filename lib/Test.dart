// // main.dart
//
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hukum App',
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hukum App Home'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Welcome to the Hukum App!'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Call the function to sign in anonymously
//                 signInAnonymously();
//               },
//               child: Text('Sign In Anonymously'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Function to sign in anonymously
//   void signInAnonymously() async {
//     try {
//       UserCredential userCredential =
//       await FirebaseAuth.instance.signInAnonymously();
//       print('Signed in as: ${userCredential.user!.uid}');
//       // You can add further actions or navigation after successful sign-in
//     } catch (e) {
//       print('Failed to sign in anonymously: $e');
//     }
//   }
// }
