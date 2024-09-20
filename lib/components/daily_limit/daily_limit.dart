import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/services/user/user.service.dart';

class DailyLimit extends StatefulWidget {
  const DailyLimit({super.key});

  @override
  State<DailyLimit> createState() => _DailyLimitState();
}

class _DailyLimitState extends State<DailyLimit> {
  int _limit = 0;
  int _currentCount = 0;
  TrafficSignImage? _lastImage;

  @override
  void initState() {
    super.initState();

    _updateImageCount();
  }

  void _updateImageCount() async {
    final UserService userService = UserService();

    final List<TrafficSignImage> lastImages =
        await userService.getCurrentUserImagesForLast(1);

    final int limit =
        await userService.getCurrentUserImageLimit().then((value) {
      return value.value;
    });

    if (mounted) {
      setState(() {
        _lastImage = lastImages.isNotEmpty ? lastImages.first : null;
        _currentCount = lastImages.length;
        _limit = limit;
      });
    }
  }

  void _showLimitDialog() {
    final untilLastImage = _lastImage != null
        ? DateTime.now()
            .difference(_lastImage!.createdAt!.add(const Duration(days: 1)))
        : null;

    // if _currentCount is zero, then show that the user can upload _limit amount of images
    // if _currentCount is not zero but less than _limit, then show how many images left
    //    and how many hours left to upload a new image
    // if _currentCount is equal to _limit, then show that the user has reached the limit
    //    and how many hours left to upload a new image

    final int numOfUploadedImage = _currentCount == 0
        ? _currentCount
        : _limit - _currentCount > 0
            ? 1
            : 2;

    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(context.tr('takePicture.dailyLimit.title')),
          children: [
            SimpleDialogOption(
              child: Text(context.plural(
                  'takePicture.dailyLimit.message', numOfUploadedImage,
                  namedArgs: {
                    'limit': (_limit - _currentCount).toString(),
                    'hoursLeft': untilLastImage?.abs().inHours.toString() ?? '',
                  })),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: _showLimitDialog,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '${_limit - _currentCount} / $_limit',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
