import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
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
    apiKey: 'AIzaSyA7tqKF6EJhW6NNQ6F6dJX_9Iip70Xxn04',
    appId: '1:1080314081562:web:035100767dca5a06e9fca3',
    messagingSenderId: '1080314081562',
    projectId: 'student-ff32f',
    authDomain: 'student-ff32f.firebaseapp.com',
    storageBucket: 'student-ff32f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAYCIdIzRfIpNpoZV1GB3M2xMKp3L3bShw',
    appId: '1:1080314081562:android:a3761514ac9cc3e7e9fca3',
    messagingSenderId: '1080314081562',
    projectId: 'student-ff32f',
    storageBucket: 'student-ff32f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzpTZ7v6HeWBmPi9m2LzWIZ-MLP-PgxNY',
    appId: '1:1080314081562:ios:2631c91c83201e8ce9fca3',
    messagingSenderId: '1080314081562',
    projectId: 'student-ff32f',
    storageBucket: 'student-ff32f.appspot.com',
    iosBundleId: 'com.example.studentAttendanceManagementSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzpTZ7v6HeWBmPi9m2LzWIZ-MLP-PgxNY',
    appId: '1:1080314081562:ios:2631c91c83201e8ce9fca3',
    messagingSenderId: '1080314081562',
    projectId: 'student-ff32f',
    storageBucket: 'student-ff32f.appspot.com',
    iosBundleId: 'com.example.studentAttendanceManagementSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA7tqKF6EJhW6NNQ6F6dJX_9Iip70Xxn04',
    appId: '1:1080314081562:web:bcd3cdd174175fbbe9fca3',
    messagingSenderId: '1080314081562',
    projectId: 'student-ff32f',
    authDomain: 'student-ff32f.firebaseapp.com',
    storageBucket: 'student-ff32f.appspot.com',
  );
}
