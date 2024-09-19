import 'dart:async';
import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:roadcognizer/views/sign_recognizer_screen/sign_recognizer_screen.dart';

class ImageDisplayScreen extends StatelessWidget {
  final String imagePath;
  final bool isPreview;

  const ImageDisplayScreen(this.imagePath, {super.key, this.isPreview = false});

  @override
  Widget build(BuildContext context) {
    final icon = isPreview ? Icons.check : Icons.close;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              if (isPreview) {
                _navigateToSignRecognizerScreen(context);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
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
        ],
      ),
    );
  }

  _navigateToSignRecognizerScreen(context) async {
    // wait for the sign recognizer screen to finish
    final completer = Completer();
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => SignRecognizerScreen(
          imagePath,
        ),
      ),
      result: completer.future,
    );

    completer.complete();
  }
}
