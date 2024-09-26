import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:roadcognizer/Views/app.dart';
import 'package:roadcognizer/models/roadcognizer_user/roadcognizer_user.dart';
import 'package:roadcognizer/services/firebase/firebase.service.dart';
import 'package:roadcognizer/services/user/user.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await MobileAds.instance.initialize();

  await FirebaseService.instance.init();

  UserService().createUserIfNotExist(
    RoadcognizerUser.fromFirebaseUser(
      FirebaseService.auth.currentUser!,
    ),
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('id', 'ID')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const App(),
    ),
  );
}
