import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';
import 'package:roadcognizer/views/image_display_screen/image_display_screen.dart';

class SignRecognizerScreen extends StatelessWidget {
  const SignRecognizerScreen({super.key});

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> openImage(BuildContext context, ImageSource source) async {
    final image =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

    if (image != null) {
      if (!context.mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImageDisplayScreen(image.path)
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
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Text Recognizer Screen"),
                  Container(
                    padding:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.image),
                          onPressed: () =>
                              openImage(context, ImageSource.gallery),
                          label: const Text("Galeri"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.camera),
                          onPressed: () =>
                              openImage(context, ImageSource.camera),
                          label: const Text("Kamera"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
