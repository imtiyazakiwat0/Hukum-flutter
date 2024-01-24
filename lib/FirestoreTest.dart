import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

class FirestoreTestScreen extends StatefulWidget {
  @override
  _FirestoreTestScreenState createState() => _FirestoreTestScreenState();
}

class _FirestoreTestScreenState extends State<FirestoreTestScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _dataController = TextEditingController();

  // Function to write data to Firestore
  Future<void> writeToFirestore(String data) async {
    try {
      await _firestore.collection('hukumData').add({
        'exampleField': data,
      });
      print('Data written to Firestore successfully!');
    } catch (e) {
      print('Error writing to Firestore: $e');
    }
  }

  // Function to read data from Firestore
  Future<void> readFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('hukumData').get();
      querySnapshot.docs.forEach((doc) {
        print('Document ID: ${doc.id}, Example Field: ${doc['exampleField']}');
      });
    } catch (e) {
      print('Error reading from Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _dataController,
              decoration: InputDecoration(labelText: 'Enter data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                writeToFirestore(_dataController.text);
              },
              child: Text('Write to Firestore'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                readFromFirestore();
              },
              child: Text('Read from Firestore'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: FirestoreTestScreen(),
  ));
}
