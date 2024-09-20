import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/sign_explanation/sign_explanation.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/views/image_display_screen/image_display_screen.dart';

class SignRecognizerDisplayScreen extends StatelessWidget {
  final TrafficSignImage trafficSignImage;

  const SignRecognizerDisplayScreen(
      {super.key, required this.trafficSignImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ImageDisplayScreen(
                    imagePathOrUrl: trafficSignImage.url,
                    image: CachedNetworkImageProvider(trafficSignImage.url),
                  ),
                ),
              );
            },
            child: Hero(
              tag: trafficSignImage.url,
              child: CachedNetworkImage(
                imageUrl: trafficSignImage.url,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 300,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: SignExplanation(
                  trafficSignImage.explanations[context.locale.languageCode] ??
                      trafficSignImage.explanations["en"]!),
            ),
          ),
        ],
      ),
    );
  }
}
