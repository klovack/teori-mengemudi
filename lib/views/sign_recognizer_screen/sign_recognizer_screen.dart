import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';
import 'package:roadcognizer/views/take_picture_screen/take_picture_screen.dart';

class SignRecognizerScreen extends StatelessWidget {
  const SignRecognizerScreen({super.key});

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> openCamera(BuildContext context) async {
    final cameras = await availableCameras();
    if (context.mounted) {
      if (cameras.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Color.fromRGBO(0, 0, 0, .5),
            elevation: 0,
            content: Text(
              "Tidak ada kamera di perangkat ini",
              textAlign: TextAlign.center,
            ),
          ),
        );

        return;
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TakePictureScreen(
            cameras: cameras,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Stack(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => navigateBack(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Text Recognizer Screen"),
                ElevatedButton.icon(
                  onPressed: () => openCamera(context),
                  icon: const Icon(Icons.camera),
                  label: const Text("Buka Kamera"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
