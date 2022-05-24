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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBWPec4TvB1F4pdpeuNToQ0_wn8RGhUTPo',
    appId: '1:1095615507835:web:5f1d7d8a8230b5a122a1de',
    messagingSenderId: '1095615507835',
    projectId: 'flutter-survivors',
    authDomain: 'flutter-survivors.firebaseapp.com',
    storageBucket: 'flutter-survivors.appspot.com',
    measurementId: 'G-75QNR77LWM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1W7BgC8YmiDgvCL_WmSpYz2znCS1nung',
    appId: '1:1095615507835:android:377b98daa5f4613222a1de',
    messagingSenderId: '1095615507835',
    projectId: 'flutter-survivors',
    storageBucket: 'flutter-survivors.appspot.com',
  );
}
