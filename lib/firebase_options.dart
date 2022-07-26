// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBBmY0NVK-LTucyQ0kaufJRmOjpSKM5f-A',
    appId: '1:168183054373:web:b1233a64b0e4b93e8abfcc',
    messagingSenderId: '168183054373',
    projectId: 'mymessenger-512a8',
    authDomain: 'mymessenger-512a8.firebaseapp.com',
    storageBucket: 'mymessenger-512a8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD67FVakWvZkmo1Vod6mNLH195xdJaHk0k',
    appId: '1:168183054373:android:d0a14d1d9a58e5768abfcc',
    messagingSenderId: '168183054373',
    projectId: 'mymessenger-512a8',
    storageBucket: 'mymessenger-512a8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA4aBROXG_pRqAadYAzGVMNU5ZBK_Vy6eo',
    appId: '1:168183054373:ios:6cf9768b322805a88abfcc',
    messagingSenderId: '168183054373',
    projectId: 'mymessenger-512a8',
    storageBucket: 'mymessenger-512a8.appspot.com',
    iosClientId: '168183054373-6qelsae6m8futa0lt0bc7gu5jfeddujc.apps.googleusercontent.com',
    iosBundleId: 'com.example.messenger',
  );
}
