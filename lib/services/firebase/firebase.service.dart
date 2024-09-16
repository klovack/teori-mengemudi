import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:roadcognizer/firebase_options.dart';
import 'package:roadcognizer/services/log/log.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  static late UserCredential _userCredential;
  // TODO: Make this value configurable
  static const String _region = "europe-west3";

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  static FirebaseService get instance => _instance;
  static UserCredential get userCredential => _userCredential;
  static FirebaseFunctions get functions =>
      FirebaseFunctions.instanceFor(region: _region);
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;
  static FirebaseAuth get auth => FirebaseAuth.instance;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await _useEmulators();
    await _appCheck();

    try {
      _userCredential = await FirebaseAuth.instance.signInAnonymously();
      log.i("Signed in with temporary account");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          log.e("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          log.e("Unknown error. Check if emulators is running. \n$e");
      }
    }
  }

  Future _appCheck() async {
    await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider:
          kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
      appleProvider: kDebugMode
          ? AppleProvider.debug
          : AppleProvider.appAttestWithDeviceCheckFallback,
    );
  }

  Future<void> _useEmulators() async {
    if (kDebugMode) {
      log.d("Use Emulators");

      const host =
          String.fromEnvironment("DEV_MACHINE_IP", defaultValue: "127.0.0.1");

      await FirebaseAuth.instance.useAuthEmulator(host, 9099);
      await FirebaseStorage.instance.useStorageEmulator(host, 9199);
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
      FirebaseService.functions.useFunctionsEmulator(host, 5001);


      firestore.settings = const Settings(
        persistenceEnabled: true,
      );

      log.d("Successfully use Emulators in $host.");
    }
  }
}
