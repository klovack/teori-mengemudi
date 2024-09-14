import 'dart:math';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadcognizer/components/app_back_button/app_back_button.dart';
import 'package:roadcognizer/components/camera/camera_controls/camera_controls.dart';
import 'package:roadcognizer/components/camera/zoom_button/zoom_button.dart';
import 'package:roadcognizer/views/image_display_screen/image_display_screen.dart';
import 'package:roadcognizer/services/log/log.dart' as logger;

class TakePictureScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const TakePictureScreen({super.key, required this.cameras});

  CameraDescription getCamera(CameraLensDirection direction) {
    return cameras.firstWhere(
      (camera) => camera.lensDirection == direction,
      orElse: () => cameras.first,
    );
  }

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription _currentCamera;
  FlashMode _flashMode = FlashMode.off;

  double _maxZoom = 1.0;
  double _minZoom = 1.0;
  final List<double> _zoomLevels = [1.0];

  bool isTakingPicture = false;

  @override
  void initState() {
    super.initState();

    _currentCamera = widget.getCamera(CameraLensDirection.back);
    _setCamera();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> takePicture(BuildContext context) async {
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      await _controller.pausePreview();

      setState(() {
        isTakingPicture = true;
      });

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await _controller.takePicture();
      if (!context.mounted) return;

      showTakenImage(image);
    } catch (e) {
      logger.log.e("Failed to take picture: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: const Color.fromRGBO(0, 0, 0, .5),
            elevation: 0,
            content: Text('takePicture.error.failToTakePicture'.tr()),
          ),
        );
      }
    }
  }

  void takeFromGallery() async {
    setState(() {
      isTakingPicture = true;
    });

    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      showTakenImage(image);
    }

    setState(() {
      isTakingPicture = false;
    });
  }

  void showTakenImage(XFile image) async {
    // If the picture was taken, display it on a new screen.
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageDisplayScreen(
          image.path,
          isPreview: true,
        ),
      ),
    );

    setState(() {
      _initializeControllerFuture = _controller.initialize();
      isTakingPicture = false;
    });
  }

  void _toggleFlash() {
    setState(() {
      _controller.setFlashMode(
        _flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off,
      );
      _flashMode =
          _flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
    });
  }

  void _toggleCamera() {
    setState(() {
      _currentCamera = _currentCamera.lensDirection == CameraLensDirection.back
          ? widget.cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
              orElse: () => _currentCamera,
            )
          : widget.cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back,
              orElse: () => _currentCamera,
            );
      _setCamera();
    });
  }

  void _setCamera() {
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      _currentCamera,
      // Define the resolution to use.
      ResolutionPreset.high,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize().then((val) {
      _setZoomLimit();
      return val;
    });
  }

  Future<void> _setZoomLimit() async {
    final maxZoom = await _controller.getMaxZoomLevel();
    final minZoom = await _controller.getMinZoomLevel();
    setState(() {
      _maxZoom = maxZoom;
      _minZoom = minZoom;
      _zoomLevels.clear();
      _zoomLevels.addAll(getCalculatedZoomLevels());
    });
  }

  List<double> getCalculatedZoomLevels() {
    final zoomDistance = (_maxZoom - _minZoom).abs();

    // If the zoom levels are too close, return a single zoom level.
    if (zoomDistance < 0.1) {
      return [1.0];
    }

    // If the zoom levels are close, return two zoom levels.
    if (zoomDistance < 1.0 && _minZoom < 1.0) {
      return [_minZoom, 1.0];
    }

    if (zoomDistance < 1.0 && _minZoom > 1.0) {
      return [1.0, _maxZoom];
    }

    if (_minZoom < 1.0) {
      if (_maxZoom <= 2.5) {
        return [_minZoom, 1.0, _maxZoom];
      }
      return [_minZoom, 1.0, 2.5, min(5.0, _maxZoom)];
    }

    // If the zoom levels are far apart, return three zoom levels.
    return [1.0, 2.5, min(5.0, _maxZoom)];
  }

  int get _initialZoomLevel {
    final index = _zoomLevels.indexOf(1.0);

    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next steps.
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: isTakingPicture
            ? null
            : () {
                takePicture(context);
              },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.camera,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final camera = _controller.value;
                final isWidthLongerThanHeight =
                    camera.previewSize!.width > camera.previewSize!.height;

                final aspectRatio = isWidthLongerThanHeight &&
                        (camera.deviceOrientation ==
                                DeviceOrientation.portraitUp ||
                            camera.deviceOrientation ==
                                DeviceOrientation.portraitDown)
                    ? camera.previewSize!.flipped.aspectRatio
                    : camera.previewSize!.aspectRatio;

                // If the Future is complete, display the preview.
                return Center(
                  child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: _controller.description.lensDirection ==
                              CameraLensDirection.front
                          ? Matrix4.rotationY(pi)
                          : Matrix4.rotationY(0),
                      child: CameraPreview(
                        _controller,
                      ),
                    ),
                  ),
                );
              } else {
                // Otherwise, display a loading indicator.
                return const SizedBox();
              }
            },
          ),

          // Back Button
          AppBackButton(navigateBack: (context) {
            Navigator.of(context).pop();
          }),

          // Camera Controls
          SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, right: 25),
                child: CameraControls(
                  toggleCamera: _toggleCamera,
                  toggleFlash: _toggleFlash,
                  isFlashOn: _flashMode == FlashMode.torch,
                  isFrontCamera:
                      _currentCamera.lensDirection == CameraLensDirection.front,
                ),
              ),
            ),
          ),

          // Zoom Controls
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 100),
                width: _zoomLevels.length * 40.0,
                child: ZoomButtons(
                  key: _currentCamera.lensDirection == CameraLensDirection.front
                      ? const Key('front_zoom_buttons')
                      : const Key('back_zoom_buttons'),
                  zoomLevels: _zoomLevels,
                  initialSelectedIndex: _initialZoomLevel,
                  onZoomLevelChange: (zoomLevel) {
                    if (_controller.value.isInitialized) {
                      _controller.setZoomLevel(zoomLevel);
                    }
                  },
                ),
              ),
            ),
          ),

          // Pick Image
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 25),
                child: IconButton(
                  onPressed: isTakingPicture ? null : takeFromGallery,
                  icon: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
