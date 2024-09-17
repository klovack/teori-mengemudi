import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/language_changer/language_changer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('profileScreen.title')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(context.tr('profileScreen.settings.title')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.tr('profileScreen.settings.language')),
                  const LanguageChanger(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
