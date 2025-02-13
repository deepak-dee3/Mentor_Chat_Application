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
    apiKey: 'AIzaSyDjni_Y2ki8q68ChZZV1H0Ei_Eu--YglWI',
    appId: '1:138636017756:web:bae51382e0073366a6a699',
    messagingSenderId: '138636017756',
    projectId: 'paramesh-stores',
    authDomain: 'paramesh-stores.firebaseapp.com',
    databaseURL: 'https://paramesh-stores-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'paramesh-stores.firebasestorage.app',
    measurementId: 'G-E3Y29BFV5C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6XI7z1obGWWiLFphRTw3pOn93oBGd7Pw',
    appId: '1:138636017756:android:24ab11e2488eb170a6a699',
    messagingSenderId: '138636017756',
    projectId: 'paramesh-stores',
    databaseURL: 'https://paramesh-stores-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'paramesh-stores.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSao4_k3APjknv-ver2HA2Tw-YNj31x3M',
    appId: '1:138636017756:ios:85f0bfaa413231e5a6a699',
    messagingSenderId: '138636017756',
    projectId: 'paramesh-stores',
    databaseURL: 'https://paramesh-stores-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'paramesh-stores.firebasestorage.app',
    iosBundleId: 'com.example.stores',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSao4_k3APjknv-ver2HA2Tw-YNj31x3M',
    appId: '1:138636017756:ios:85f0bfaa413231e5a6a699',
    messagingSenderId: '138636017756',
    projectId: 'paramesh-stores',
    databaseURL: 'https://paramesh-stores-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'paramesh-stores.firebasestorage.app',
    iosBundleId: 'com.example.stores',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDjni_Y2ki8q68ChZZV1H0Ei_Eu--YglWI',
    appId: '1:138636017756:web:e0dfadbffa99a71da6a699',
    messagingSenderId: '138636017756',
    projectId: 'paramesh-stores',
    authDomain: 'paramesh-stores.firebaseapp.com',
    databaseURL: 'https://paramesh-stores-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'paramesh-stores.firebasestorage.app',
    measurementId: 'G-KV49JLD418',
  );
}
