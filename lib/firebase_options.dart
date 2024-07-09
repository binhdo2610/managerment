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
    apiKey: 'AIzaSyCfbTOhbf1FgG-5LXIdaORTX2Ov8LRiqqM',
    appId: '1:148198581496:web:f8c3d9a1b9bce7b9df470d',
    messagingSenderId: '148198581496',
    projectId: 'groupchat-d69aa',
    authDomain: 'groupchat-d69aa.firebaseapp.com',
    storageBucket: 'groupchat-d69aa.appspot.com',
    measurementId: 'G-SW846WG6L4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJfJvHioWotdoKvmIthDkdvi4WCxaEhsk',
    appId: '1:148198581496:android:54fbdb594d6e3f73df470d',
    messagingSenderId: '148198581496',
    projectId: 'groupchat-d69aa',
    storageBucket: 'groupchat-d69aa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-zVgRCNxYS0lsfFXvy3u4cHfINIl9XhY',
    appId: '1:148198581496:ios:c2e4b8389d293594df470d',
    messagingSenderId: '148198581496',
    projectId: 'groupchat-d69aa',
    storageBucket: 'groupchat-d69aa.appspot.com',
    iosBundleId: 'com.example.ui',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-zVgRCNxYS0lsfFXvy3u4cHfINIl9XhY',
    appId: '1:148198581496:ios:c2e4b8389d293594df470d',
    messagingSenderId: '148198581496',
    projectId: 'groupchat-d69aa',
    storageBucket: 'groupchat-d69aa.appspot.com',
    iosBundleId: 'com.example.ui',
  );

}