import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:roadcognizer/components/app_back_button/app_back_button.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';
import 'package:roadcognizer/services/upload_image/upload_image.service.dart';
import 'package:roadcognizer/views/image_display_screen/image_display_screen.dart';

class SignRecognizerScreen extends StatefulWidget {
  final String imagePath;

  const SignRecognizerScreen(this.imagePath, {super.key});

  @override
  State<SignRecognizerScreen> createState() => _SignRecognizerScreenState();
}

class _SignRecognizerScreenState extends State<SignRecognizerScreen> {
  String? _downloadableUrl;

  @override
  void initState() {
    super.initState();

    uploadImage(widget.imagePath).then((value) {
      setState(() {
        _downloadableUrl = value;
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengunggah gambar $e'),
        ),
      );
    });
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
              if (_downloadableUrl == null) const LinearProgressIndicator(),
              if (_downloadableUrl != null) Text(_downloadableUrl!),
            ],
          ),

          // Back Button
          AppBackButton(navigateBack: navigateBack),
        ],
      ),
    );
  }
}
