import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/exception/exception.dart';
import 'package:roadcognizer/services/log/log.dart';
import 'package:roadcognizer/theme/fonts.dart';

class ErrorDialog extends StatelessWidget {
  late final String title;
  late final String message;
  late final String retry;
  final RoadcognizerException? exception;

  ErrorDialog({
    super.key,
    this.exception,
  }) {
    var message = 'signRecognizer.error.message';
    var title = 'signRecognizer.error.title';
    var retry = 'signRecognizer.error.retry';

    if (exception != null) {
      if (exception is UploadImageException) {
        message = exception!.message;
      } else if (exception is ReadTrafficException) {
        message = exception!.message;
      } else if (exception is UserImageLimitReachedException) {
        message = exception!.message;
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
      ],
    );
  }
}
