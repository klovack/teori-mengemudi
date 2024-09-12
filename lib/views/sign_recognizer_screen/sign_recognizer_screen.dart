import 'dart:async';
import 'dart:io' show File;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:roadcognizer/components/app_back_button/app_back_button.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';
import 'package:roadcognizer/components/sign_explanation/sign_explanation.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';
import 'package:roadcognizer/services/log/log.dart';
import 'package:roadcognizer/services/read_traffic_sign/read_traffic_sign.dart';
import 'package:roadcognizer/services/upload_image/upload_image.service.dart';
import 'package:roadcognizer/theme/fonts.dart';
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
      uploadAndReadTrafficSign(languageCode);
    });
  }

  Future uploadAndReadTrafficSign(String languageCode) async {
    try {
      final imageUrl = await uploadImage(widget.imagePath);
      final trafficSign = await readTrafficSign(
        imageUrl,
        languageCode: languageCode,
      );
      setState(() {
        _trafficSign = trafficSign;
      });
    } catch (e) {
      log.e("Error reading traffic sign: $e");
      showErrorDialog();
    }
  }

  void showErrorDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'signRecognizer.error.title'.tr(),
            style: Fonts.getPrimary(),
          ),
          content: Text(
            'signRecognizer.error.message'.tr(),
            style: Fonts.getSecondary(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(ctx).pop();
              },
              child: const Text('signRecognizer.error.retry').tr(),
            ),
          ],
        );
      },
    );
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  void navigateToImageDisplayScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageDisplayScreen(widget.imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Stack(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  navigateToImageDisplayScreen(context);
                },
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
            navigateBack: navigateBack,
            backgroundColor: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
