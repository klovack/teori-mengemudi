import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roadcognizer/config.constants.dart';
import 'package:roadcognizer/theme/dark.dart';
import 'package:roadcognizer/theme/light.dart';
import 'package:roadcognizer/views/menu_screen/menu_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final title =
        appFlavor == AppFlavor.dev.value ? 'Roadcognizer Dev' : 'Roadcognizer';
    return MaterialApp(
      title: title,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MenuScreen(),
    );
  }
}
