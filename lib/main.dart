import 'package:flutter/material.dart';
import 'package:roadcognizer/Views/app.dart';
import 'package:roadcognizer/services/firebase/firebase.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService.instance.init();

  runApp(const App());
}
