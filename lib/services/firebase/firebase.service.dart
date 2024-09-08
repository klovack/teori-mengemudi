import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:roadcognizer/firebase_options.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  static UserCredential? _userCredential;
  // TODO: Make this value configurable
  static const String _region = "europe-west3";

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  static FirebaseService get instance => _instance;
  static UserCredential? get userCredential => _userCredential;
  static FirebaseFunctions get functions =>
      FirebaseFunctions.instanceFor(region: _region);
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  static FirebaseDatabase get database => FirebaseDatabase.instance;
  static FirebaseStorage get storage => FirebaseStorage.instance;
  static FirebaseAuth get auth => FirebaseAuth.instance;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await _useEmulators();

    try {
      _userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error. Check if emulators is running.");
      }
    }
  }

  Future<void> _useEmulators() async {
    if (kDebugMode) {
      print("Use Emulators");
      await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
      await FirebaseStorage.instance.useStorageEmulator('127.0.0.1', 9199);
      FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
      FirebaseDatabase.instance.useDatabaseEmulator('127.0.0.1', 9000);
      FirebaseService.functions.useFunctionsEmulator('127.0.0.1', 5001);
    }
  }
}
