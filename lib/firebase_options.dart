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
    apiKey: 'AIzaSyBmkDT4lOmG0MtnziW9c0oBn2sf5Ox9rko',
    appId: '1:60203381452:web:e3fce4887d6d14d36b4869',
    messagingSenderId: '60203381452',
    projectId: 'handimart-fe5cc',
    authDomain: 'handimart-fe5cc.firebaseapp.com',
    storageBucket: 'handimart-fe5cc.appspot.com',
    measurementId: 'G-6MSZFKQ6B5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJHQ--TPbURfQGdRYHsdpc3WzX66VLJP8',
    appId: '1:60203381452:android:213cbc7c7f80bffd6b4869',
    messagingSenderId: '60203381452',
    projectId: 'handimart-fe5cc',
    storageBucket: 'handimart-fe5cc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBitn6eszXIh6roJyPPhuOovX7_Hcdhbu0',
    appId: '1:60203381452:ios:5f781080c1f24c9e6b4869',
    messagingSenderId: '60203381452',
    projectId: 'handimart-fe5cc',
    storageBucket: 'handimart-fe5cc.appspot.com',
    androidClientId: '60203381452-qbsj9h9m2sti490u4arute67qu9tp7g8.apps.googleusercontent.com',
    iosClientId: '60203381452-a6sr55rdf1aemd6nd3tnqbs1rgmn0fb4.apps.googleusercontent.com',
    iosBundleId: 'com.example.tStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBitn6eszXIh6roJyPPhuOovX7_Hcdhbu0',
    appId: '1:60203381452:ios:e5f572042610422e6b4869',
    messagingSenderId: '60203381452',
    projectId: 'handimart-fe5cc',
    storageBucket: 'handimart-fe5cc.appspot.com',
    androidClientId: '60203381452-qbsj9h9m2sti490u4arute67qu9tp7g8.apps.googleusercontent.com',
    iosClientId: '60203381452-80lo296r50re9vnntdacua69o0m4b4kq.apps.googleusercontent.com',
    iosBundleId: 'com.example.tStore.RunnerTests',
  );
}
