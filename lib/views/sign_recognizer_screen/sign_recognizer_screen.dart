import 'package:flutter/material.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';

class SignRecognizerScreen extends StatelessWidget {
  const SignRecognizerScreen({super.key});

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Stack(
        children: [
          Positioned(
            top: 70,
            left: 10,
            child: IconButton(
                onPressed: () => navigateBack(context),
                icon: const Icon(Icons.arrow_back)),
          ),
          const Center(
            child: Text("Text Recognizer Screen"),
          ),
        ],
      ),
    );
  }
}
