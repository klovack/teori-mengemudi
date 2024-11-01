import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/sign_explanation/draggable_sign_explanation.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/views/image_display_screen/image_display_screen.dart';
import 'package:roadcognizer/views/profile_screen/profile_screen.dart';

class SignRecognizerDisplayScreen extends StatelessWidget {
  final TrafficSignImage trafficSignImage;

  const SignRecognizerDisplayScreen(
      {super.key, required this.trafficSignImage});

  @override
  Widget build(BuildContext context) {
    final hasExplanation =
        trafficSignImage.explanations[context.locale.languageCode] != null;
    final availableExplanation = hasExplanation
        ? context.locale.languageCode
        : trafficSignImage.explanations.keys.first;

    final availableLanguage =
        context.tr('supportedLanguages.$availableExplanation');

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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
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
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              hasExplanation
                  ? DraggableSignExplanation(
                      trafficSign: trafficSignImage
                              .explanations[context.locale.languageCode] ??
                          trafficSignImage.explanations["en"]!,
                    )
                  : _NoExplanation(
                      availableLanguage: availableLanguage,
                    ),
            ],
          );
        },
      ),
    );
  }
}

class _NoExplanation extends StatelessWidget {
  final String availableLanguage;
  const _NoExplanation({
    super.key,
    required this.availableLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: .2,
        minChildSize: .2,
        maxChildSize: .2,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Text(
                    context.tr('signRecognizer.noExplanationLanguage.title'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.tr('signRecognizer.noExplanationLanguage.message',
                        args: [availableLanguage]),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProfileScreen(),
                          ),
                        );
                      },
                      child: Text(
                        context.tr(
                          'signRecognizer.noExplanationLanguage.switchLanguage',
                          args: [availableLanguage],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
