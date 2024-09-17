import 'dart:async';
import 'dart:io' show File;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:roadcognizer/components/app_back_button/app_back_button.dart';
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
      final languageCode =
          EasyLocalization.of(context)!.currentLocale!.languageCode;
      _uploadAndReadTrafficSign(languageCode);
    });
  }

  Future _uploadAndReadTrafficSign(String languageCode) async {
    try {
      final isLimitReached =
          await UserService().isCurrentUserImageLimitReached();
      if (isLimitReached) {
        throw UserImageLimitReachedException(
          "User has reached today's image limit.",
        );
      }
    } catch (e) {
      log.e("User has reached limit: $e");
      _showErrorDialog(e is RoadcognizerException ? e : null);
      return;
    }

    try {
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
    } catch (e) {
      log.e("Error reading traffic sign: $e");
      _showErrorDialog(e is RoadcognizerException ? e : null);
    }
  }

  void _storeTrafficSign(String imageUrl, String languageCode) async {
    try {
      await UserService().addImageToCurrentUser(
        TrafficSignImage(
          url: imageUrl,
          explanations: {
            languageCode: _trafficSign!,
          },
        ),
      );
    } catch (e) {
      log.e("Error storing traffic sign: $e");
      _showErrorDialog(e is RoadcognizerException ? e : null);
    }
  } 

  void _showErrorDialog([RoadcognizerException? e]) {
    showAdaptiveDialog(
      context: context,
      builder: (ctx) {
        return ErrorDialog(
          exception: e,
        );
      },
    );
  }

  void _navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void _navigateToImageDisplayScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageDisplayScreen(widget.imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
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

          // Back Button
          AppBackButton(
            navigateBack: _navigateBack,
            backgroundColor: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
