import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:roadcognizer/components/app_back_button/app_back_button.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';
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

    uploadImage(widget.imagePath).then((imageUrl) async {
      final trafficSign = await readTrafficSign(imageUrl);
      setState(() {
        _trafficSign = trafficSign;
      });
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal mengenali tanda'),
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
              if (_trafficSign == null) const LinearProgressIndicator(),
              if (_trafficSign != null)
                Container(
                  height: MediaQuery.of(context).size.height - 300,
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Penjelasan",
                          textAlign: TextAlign.left,
                          style: Fonts.getPrimary(
                            ts: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Text(
                          "Asal: ${_trafficSign!.origin}",
                          style: Fonts.getSecondary(
                            ts: const TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _trafficSign!.explanation,
                          style: Fonts.getSecondary(),
                        ),
                        const SizedBox(height: 20),
                        ..._trafficSign!.signs.map((sign) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sign.signName,
                                    style: Fonts.getPrimary(),
                                  ),
                                  Text(
                                    sign.description,
                                    style: Fonts.getSecondary(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
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
