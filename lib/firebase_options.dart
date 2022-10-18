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
    apiKey: 'AIzaSyBmUkusU6KcN_Rjown4AAr1hJmxC0tCXuE',
    appId: '1:1045357820998:web:427d6df79b586474c41e47',
    messagingSenderId: '1045357820998',
    projectId: 'semifinal-72299',
    authDomain: 'semifinal-72299.firebaseapp.com',
    storageBucket: 'semifinal-72299.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTGWgYg61eeBYnrwZ-t6YKJU67IPHpUzY',
    appId: '1:1045357820998:android:952d8a3a8a65a625c41e47',
    messagingSenderId: '1045357820998',
    projectId: 'semifinal-72299',
    storageBucket: 'semifinal-72299.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAY4PI3lUHUygM4NkPqoZfJTDzAgkqgKkg',
    appId: '1:1045357820998:ios:63616a3576ea5bcfc41e47',
    messagingSenderId: '1045357820998',
    projectId: 'semifinal-72299',
    storageBucket: 'semifinal-72299.appspot.com',
    iosClientId: '1045357820998-98duq5q3k2i9i99ihq6e422n47ijn2qj.apps.googleusercontent.com',
    iosBundleId: 'com.example.citycafeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAY4PI3lUHUygM4NkPqoZfJTDzAgkqgKkg',
    appId: '1:1045357820998:ios:63616a3576ea5bcfc41e47',
    messagingSenderId: '1045357820998',
    projectId: 'semifinal-72299',
    storageBucket: 'semifinal-72299.appspot.com',
    iosClientId: '1045357820998-98duq5q3k2i9i99ihq6e422n47ijn2qj.apps.googleusercontent.com',
    iosBundleId: 'com.example.citycafeApp',
  );
}
