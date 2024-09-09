import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:roadcognizer/components/app_back_button/app_back_button.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';
import 'package:roadcognizer/views/image_display_screen/image_display_screen.dart';

class SignRecognizerScreen extends StatelessWidget {
  final String imagePath;

  const SignRecognizerScreen(this.imagePath, {super.key});

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void navigateToImageDisplayScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageDisplayScreen(imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Stack(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  navigateToImageDisplayScreen(context);
                },
                child: Hero(
                  tag: imagePath,
                  child: Image.file(
                    File(imagePath),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const LinearProgressIndicator(),
            ],
          ),


          // Back Button
          AppBackButton(navigateBack: navigateBack),
        ],
      ),
    );
  }
}
