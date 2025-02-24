// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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
        return windows;
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
    apiKey: 'AIzaSyDawhLRRxWWSPxlkAfw67lfy4RwJFEz8ek',
    appId: '1:465710872572:web:5f5942e11a63a252cfe479',
    messagingSenderId: '465710872572',
    projectId: 'cashclicks-ea438',
    authDomain: 'cashclicks-ea438.firebaseapp.com',
    storageBucket: 'cashclicks-ea438.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCq-GCnRYFjK68nnJne8yXC6IGtmp6aaxs',
    appId: '1:465710872572:android:ed816b1671de9120cfe479',
    messagingSenderId: '465710872572',
    projectId: 'cashclicks-ea438',
    storageBucket: 'cashclicks-ea438.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZFR9UVSYhLsqpqST9Zizti5ncceIb2Bk',
    appId: '1:465710872572:ios:86e577b44896b029cfe479',
    messagingSenderId: '465710872572',
    projectId: 'cashclicks-ea438',
    storageBucket: 'cashclicks-ea438.appspot.com',
    iosBundleId: 'com.example.cashclicks',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZFR9UVSYhLsqpqST9Zizti5ncceIb2Bk',
    appId: '1:465710872572:ios:86e577b44896b029cfe479',
    messagingSenderId: '465710872572',
    projectId: 'cashclicks-ea438',
    storageBucket: 'cashclicks-ea438.appspot.com',
    iosBundleId: 'com.example.cashclicks',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDawhLRRxWWSPxlkAfw67lfy4RwJFEz8ek',
    appId: '1:465710872572:web:ff9df0acf60a4411cfe479',
    messagingSenderId: '465710872572',
    projectId: 'cashclicks-ea438',
    authDomain: 'cashclicks-ea438.firebaseapp.com',
    storageBucket: 'cashclicks-ea438.appspot.com',
  );
}
