import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/language_changer/language_changer.dart';
import 'package:roadcognizer/theme/fonts.dart';
import 'package:roadcognizer/views/take_picture_screen/take_picture_screen.dart';

class StartScreen extends StatelessWidget {
  final void Function() onStart;

  const StartScreen({
    super.key,
    required this.onStart,
  });

  Future<void> navigateToSignRecognizer(BuildContext context) async {
    final cameras = await availableCameras();

    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(
          cameras: cameras,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const SafeArea(
          child: Align(
            alignment: Alignment.topRight,
            child: LanguageChanger(),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 150),
              SizedBox(
                width: 150,
                child: Text(
                  "Roadcognizer",
                  textAlign: TextAlign.center,
                  style: Fonts.getPrimary(
                    ts: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              Text(tr('ctaReadyToDrive'), style: Fonts.getSecondary()),
              const SizedBox(height: 25),

              // Start Camera
              ElevatedButton.icon(
                iconAlignment: IconAlignment.start,
                icon: const Icon(Icons.camera),
                onPressed: () {
                  navigateToSignRecognizer(context);
                },
                label: Text('ctaReadTrafficSign'.tr()),
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

              // Practice Driving Theory
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 270,
                  child: TextButton(
                    onPressed: onStart,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      foregroundColor: Colors.deepOrange.shade900,
                    ),
                    child: Text(
                      tr('practiceDrivingTheory'),
                      style:
                          Fonts.getSecondary(
                        ts: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
