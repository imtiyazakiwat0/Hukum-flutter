// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// / Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDOj7wX2VznoBVzIvto2yzL7ZFVldQN1zE',
    appId: '1:217599773757:web:8842b2aaf647326ae36e54',
    messagingSenderId: '217599773757',
    projectId: 'hukum-c3925',
    authDomain: 'hukum-c3925.firebaseapp.com',
    // authDomain: 'hukum.imtiyazakiwat.online',
    databaseURL: 'https://hukum-c3925-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hukum-c3925.appspot.com',
    measurementId: 'G-8ZRD9P57H6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAIlcxoudOiqNrGnzJM-QOh11vuCnEK_BI',
    appId: '1:217599773757:android:8852e62185fae0a5e36e54',
    messagingSenderId: '217599773757',
    projectId: 'hukum-c3925',
    databaseURL: 'https://hukum-c3925-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hukum-c3925.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_lGpT7DT9GwJSt1NcOlIVreaCDAdGQqk',
    appId: '1:217599773757:ios:e2f672d193ee9c3fe36e54',
    messagingSenderId: '217599773757',
    projectId: 'hukum-c3925',
    databaseURL: 'https://hukum-c3925-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hukum-c3925.appspot.com',
    iosClientId: '217599773757-3lad1e5c0b8oeu9v4i4s1fosfg6si2vu.apps.googleusercontent.com',
    iosBundleId: 'com.example.myfirstproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_lGpT7DT9GwJSt1NcOlIVreaCDAdGQqk',
    appId: '1:217599773757:ios:ff1d3a526e3d5721e36e54',
    messagingSenderId: '217599773757',
    projectId: 'hukum-c3925',
    databaseURL: 'https://hukum-c3925-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'hukum-c3925.appspot.com',
    iosClientId: '217599773757-lrtuj625lji78sfpp6jsg495pvabant9.apps.googleusercontent.com',
    iosBundleId: 'com.example.myfirstproject.RunnerTests',
  );
}
