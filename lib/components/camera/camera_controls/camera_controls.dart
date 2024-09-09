import 'package:flutter/material.dart';

class CameraControls extends StatelessWidget {
  final Function()? toggleCamera;
  final Function()? toggleFlash;
  final bool isFlashOn;
  final bool isFrontCamera;

  const CameraControls({
    super.key,
    required this.toggleCamera,
    required this.toggleFlash,
    required this.isFlashOn,
    required this.isFrontCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: toggleCamera,
          icon: const Icon(
            Icons.flip_camera_android,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: isFrontCamera ? null : toggleFlash,
          icon: !isFlashOn || isFrontCamera
              ? Icon(
                  Icons.flash_off,
                  color: isFrontCamera ? Colors.white24 : Colors.white,
                )
              : const Icon(
                  Icons.flash_on,
                  color: Colors.yellow,
                ),
        ),
      ],
    );
  }
}
