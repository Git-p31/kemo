import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCKI6ETxNYpcr4AMBPJQjfD_Y5NSZ_CTwo",
    appId: "1:349843556629:android:af962bcb220a40493c011c",
    messagingSenderId: "349843556629",
    projectId: "kemo-2025",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyCKI6ETxNYpcr4AMBPJQjfD_Y5NSZ_CTwo",
    appId: "1:349843556629:ios:af962bcb220a40493c011c",
    messagingSenderId: "349843556629",
    projectId: "kemo-2025",
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyCKI6ETxNYpcr4AMBPJQjfD_Y5NSZ_CTwo",
    appId: "1:349843556629:web:af962bcb220a40493c011c",
    messagingSenderId: "349843556629",
    projectId: "kemo-2025",
    authDomain: "kemo-2025.firebaseapp.com",
    storageBucket: "kemo-2025.appspot.com",
  );
}