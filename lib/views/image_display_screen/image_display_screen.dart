import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roadcognizer/views/sign_recognizer_screen/sign_recognizer_screen.dart';

class ImageDisplayScreen extends StatelessWidget {
  final String imagePathOrUrl;
  final ImageProvider image;
  final bool isPreview;

  const ImageDisplayScreen({
    super.key,
    this.isPreview = false,
    required this.image,
    required this.imagePathOrUrl,
  });

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
                tag: imagePathOrUrl,
                child: Image(image: image),
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
          imagePathOrUrl,
        ),
      ),
      result: completer.future,
    );

    completer.complete();
  }
}
