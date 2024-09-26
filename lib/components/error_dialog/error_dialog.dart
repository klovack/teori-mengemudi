import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/reward_ad/reward_ad.dart';
import 'package:roadcognizer/exception/exception.dart';
import 'package:roadcognizer/services/log/log.dart';
import 'package:roadcognizer/theme/fonts.dart';

class ErrorDialog extends StatelessWidget {
  late final String title;
  late final String message;
  late final String retry;
  final RoadcognizerException? exception;
  final Function()? onUserEarnedImageQuota;

  ErrorDialog({
    super.key,
    this.exception,
    this.onUserEarnedImageQuota,
  }) {
    var message = 'signRecognizer.error.message';
    var title = 'signRecognizer.error.title';
    var retry = 'signRecognizer.error.retry';

    if (exception != null) {
      if (exception is UploadImageException) {
        title = 'signRecognizer.error.uploadImage.title';
        message = 'signRecognizer.error.uploadImage.message';
        retry = 'signRecognizer.error.uploadImage.retry';
      } else if (exception is ReadTrafficException) {
        title = 'signRecognizer.error.noTrafficSign.title';
        message = 'signRecognizer.error.noTrafficSign.message';
        retry = 'signRecognizer.error.noTrafficSign.retry';
      } else if (exception is UserImageLimitReachedException) {
        title = 'signRecognizer.error.imageLimit.title';
        message = 'signRecognizer.error.imageLimit.message';
        retry = 'signRecognizer.error.imageLimit.retry';
      }
    }

    this.title = title;
    this.message = message;
    this.retry = retry;
  }

  @override
  Widget build(BuildContext context) {
    log.e("Error in the app: $exception");
    return AlertDialog(
      title: Text(
        title.tr(),
        style: Fonts.getPrimary(),
      ),
      content: Text(
        message.tr(),
        style: Fonts.getSecondary(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text(retry).tr(),
        ),
        if (exception is UserImageLimitReachedException)
          RewardAd(
            onUserEarnedReward: () {
              Navigator.of(context).pop();
              onUserEarnedImageQuota?.call();
            },
          ),
      ],
    );
  }
}
