import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:roadcognizer/components/app_back_button/app_back_button.dart';
import 'package:roadcognizer/views/sign_recognizer_screen/sign_recognizer_screen.dart';

class ImageDisplayScreen extends StatelessWidget {
  final String imagePath;
  final bool isPreview;

  const ImageDisplayScreen(this.imagePath, {super.key, this.isPreview = false});

  @override
  Widget build(BuildContext context) {
    final icon = isPreview ? Icons.check : Icons.close;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          InteractiveViewer(
            child: Center(
              child: Hero(
                tag: imagePath,
                child: Image.file(
                  File(
                    imagePath,
                  ),
                ),
              ),
            ),
          ),

          // Add a back button here
          AppBackButton(
            icon: icon,
            alignment: Alignment.topRight,
            navigateBack: isPreview
                ? (context) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignRecognizerScreen(
                          imagePath,
                        ),
                      ),
                    );
                  }
                : null,
          )
        ],
      ),
    );
  }
}
