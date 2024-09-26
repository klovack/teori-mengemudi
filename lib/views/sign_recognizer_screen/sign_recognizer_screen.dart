import 'dart:async';
import 'dart:io' show File;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:roadcognizer/components/error_dialog/error_dialog.dart';
import 'package:roadcognizer/components/sign_explanation/sign_explanation.dart';
import 'package:roadcognizer/exception/exception.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/services/log/log.dart';
import 'package:roadcognizer/services/read_traffic_sign/read_traffic_sign.dart';
import 'package:roadcognizer/services/upload_image/upload_image.service.dart';
import 'package:roadcognizer/services/user/user.service.dart';
import 'package:roadcognizer/views/image_display_screen/image_display_screen.dart';

class SignRecognizerScreen extends StatefulWidget {
  final String imagePath;

  const SignRecognizerScreen(this.imagePath, {super.key});

  @override
  State<SignRecognizerScreen> createState() => _SignRecognizerScreenState();
}

class _SignRecognizerScreenState extends State<SignRecognizerScreen> {
  TrafficSignDescription? _trafficSign;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _readTrafficSign(true);
    });
  }

  void _readTrafficSign(bool checkImageLimit) async {
    final languageCode =
        EasyLocalization.of(context)!.currentLocale!.languageCode;

    try {
      if (checkImageLimit) {
        await _checkImageLimit();
      }
      await _uploadAndReadTrafficSign(languageCode);
    } catch (e) {
      log.e("Error has occurred when reading the traffic sign: $e");
      _showErrorDialog(e is RoadcognizerException ? e : null);
    }
  }

  Future _checkImageLimit() async {
    final isLimitReached = await UserService().isCurrentUserImageLimitReached();
    if (isLimitReached) {
      throw UserImageLimitReachedException(
        "User has reached today's image limit.",
      );
    }
  }

  Future _uploadAndReadTrafficSign(String languageCode) async {
    final imageUrl = await uploadImage(widget.imagePath);
    final trafficSign = await readTrafficSign(
      imageUrl,
      languageCode: languageCode,
    );
    if (trafficSign.error != null && trafficSign.error!.isNotEmpty) {
      log.e("Problem reading the traffic sign: ${trafficSign.error}");
      throw ReadTrafficException(
          "Error reading traffic sign: ${trafficSign.error}");
    }
    setState(() {
      _trafficSign = trafficSign;
    });
    _storeTrafficSign(imageUrl, languageCode);
  }

  void _storeTrafficSign(String imageUrl, String languageCode) async {
    await UserService().addImageToCurrentUser(
      TrafficSignImage(
        url: imageUrl,
        explanations: {
          languageCode: _trafficSign!,
        },
      ),
    );
  } 

  void _showErrorDialog([RoadcognizerException? e]) {
    showAdaptiveDialog(
      context: context,
      builder: (ctx) {
        return ErrorDialog(
          exception: e,
          onUserEarnedImageQuota: () => _readTrafficSign(false),
        );
      },
    );
  }

  void _navigateToImageDisplayScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageDisplayScreen(
          imagePathOrUrl: widget.imagePath,
          image: FileImage(File(widget.imagePath)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          style: IconButton.styleFrom(
            elevation: 10,
          ),
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _navigateToImageDisplayScreen,
            child: Hero(
              tag: widget.imagePath,
              child: Image.file(
                File(widget.imagePath),
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (_trafficSign == null) const LinearProgressIndicator(),
          if (_trafficSign != null)
            Container(
              height: MediaQuery.of(context).size.height - 300,
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: SignExplanation(_trafficSign!),
              ),
            ),
        ],
      ),
    );
  }
}
