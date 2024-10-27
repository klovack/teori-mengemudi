import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/views/sign_recognizer_display_screen/sign_recognizer_display_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SignCard extends StatelessWidget {
  final TrafficSignImage? image;
  final bool isLoading;
  final Function(TrafficSignImage)? onDelete;

  const SignCard({
    super.key,
    required this.image,
    required this.isLoading,
    this.onDelete,
  });

  void _navigateToSignRecognizerScreen(BuildContext context) {
    if (image == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SignRecognizerDisplayScreen(
          trafficSignImage: image!,
        ),
      ),
    );
  }

  void _deleteSign(BuildContext context) {
    if (image == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.tr('userSigns.card.delete.title')),
          content: Text(context.tr('userSigns.card.delete.message')),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(context.tr('userSigns.card.delete.cancel')),
            ),
            TextButton(
              onPressed: () {
                onDelete?.call(image!);
                Navigator.of(context).pop();
              },
              child: Text(context.tr('userSigns.card.delete.confirm')),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () => _navigateToSignRecognizerScreen(context),
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (image != null)
                Hero(
                  tag: image!.url,
                  child: CachedNetworkImage(
                    imageUrl: image!.url,
                    fit: BoxFit.cover,
                    colorBlendMode: BlendMode.darken,
                    color: Colors.black.withOpacity(0.2),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GestureDetector(
                    onTap: () {
                      _deleteSign(context);
                    },
                    child: Icon(
                      Icons.close_rounded,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withOpacity(0.8),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
