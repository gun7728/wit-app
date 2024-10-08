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
    apiKey: 'AIzaSyDaMb8lesNcOS1_hdtgR0jijtGexohlmdk',
    appId: '1:903020520787:web:e9bd968bba945f832eeda6',
    messagingSenderId: '903020520787',
    projectId: 'wit-app-4459c',
    authDomain: 'wit-app-4459c.firebaseapp.com',
    storageBucket: 'wit-app-4459c.appspot.com',
    measurementId: 'G-BYHMD3MP04',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9uW40yImIHARzTBCStvAG2GcIWkTJooU',
    appId: '1:903020520787:android:200b0ea8cc4d62b62eeda6',
    messagingSenderId: '903020520787',
    projectId: 'wit-app-4459c',
    storageBucket: 'wit-app-4459c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYcqNXvbLFDoHM__1vCnTPIuIJz-YtZIg',
    appId: '1:903020520787:ios:1b99720ee246b5c22eeda6',
    messagingSenderId: '903020520787',
    projectId: 'wit-app-4459c',
    storageBucket: 'wit-app-4459c.appspot.com',
    iosBundleId: 'wit.witApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYcqNXvbLFDoHM__1vCnTPIuIJz-YtZIg',
    appId: '1:903020520787:ios:e0212cc3ddf4661b2eeda6',
    messagingSenderId: '903020520787',
    projectId: 'wit-app-4459c',
    storageBucket: 'wit-app-4459c.appspot.com',
    iosBundleId: 'com.example.witApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDaMb8lesNcOS1_hdtgR0jijtGexohlmdk',
    appId: '1:903020520787:web:b9f7a0e89f0f78b82eeda6',
    messagingSenderId: '903020520787',
    projectId: 'wit-app-4459c',
    authDomain: 'wit-app-4459c.firebaseapp.com',
    storageBucket: 'wit-app-4459c.appspot.com',
    measurementId: 'G-W113B95ZXS',
  );
}
