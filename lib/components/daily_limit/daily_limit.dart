import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/reward_ad/reward_ad.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';
import 'package:roadcognizer/services/user/user.service.dart';

class DailyLimit extends StatefulWidget {
  const DailyLimit({super.key});

  @override
  State<DailyLimit> createState() => _DailyLimitState();
}

class _DailyLimitState extends State<DailyLimit> {
  final UserService _userService = UserService();
  
  int _limit = 0;
  int _currentCount = 0;
  TrafficSignImage? _lastImage;

  @override
  void initState() {
    super.initState();

    _updateImageCount();
  }

  void _updateImageCount() async {
    final List<TrafficSignImage> lastImages =
        await _userService.getCurrentUserImagesForLast(1);

    final int limit = await _userService.getCurrentUserImageLimit();

    if (mounted) {
      setState(() {
        _lastImage = lastImages.isNotEmpty ? lastImages.first : null;
        _currentCount = lastImages.length;
        _limit = limit;
      });

      if (_currentCount >= _limit) {
        _showLimitDialog();
      }
    }
  }

  void _showLimitDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return DailyLimitDialog(
          limit: _limit,
          currentCount: _currentCount,
          numOfUploadedImage: 0,
          lastImage: _lastImage,
          onUserEarnedImageQuota: _onUserEarnedImageQuota,
        );
      },
    );
  }

  Future _onUserEarnedImageQuota() async {
    await _userService.incrementExtraImageQuotaToCurrentUser();

    _updateImageCount();
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
              '${max(_limit - _currentCount, 0)} / $_limit',
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

class DailyLimitDialog extends StatefulWidget {
  final int limit;
  final int currentCount;
  final int numOfUploadedImage;
  final TrafficSignImage? lastImage;
  final Function()? onUserEarnedImageQuota;

  const DailyLimitDialog({
    super.key,
    required this.limit,
    required this.currentCount,
    required this.numOfUploadedImage,
    required this.lastImage,
    this.onUserEarnedImageQuota,
  });

  @override
  State<DailyLimitDialog> createState() => _DailyLimitDialogState();
}

class _DailyLimitDialogState extends State<DailyLimitDialog> {
  bool _isAdLoaded = false;

  @override
  Widget build(BuildContext context) {
    final untilLastImage = widget.lastImage != null
        ? DateTime.now().difference(
            widget.lastImage!.createdAt!.add(const Duration(days: 1)))
        : null;

    final hasReachedLimit = widget.currentCount >= widget.limit;

    // if _currentCount is zero, then show that the user can upload _limit amount of images
    // if _currentCount is not zero but less than _limit, then show how many images left
    //    and how many hours left to upload a new image
    // if _currentCount is equal to _limit, then show that the user has reached the limit
    //    and how many hours left to upload a new image

    final int numOfUploadedImage = widget.currentCount == 0
        ? widget.currentCount
        : widget.limit - widget.currentCount > 0
            ? 1
            : 2;

    return SimpleDialog(
      title: Text(context.tr('takePicture.dailyLimit.title')),
      children: [
        SimpleDialogOption(
          child: Text(context.plural(
              'takePicture.dailyLimit.message', numOfUploadedImage,
              namedArgs: {
                'limit': (widget.limit - widget.currentCount).toString(),
                'hoursLeft': untilLastImage?.abs().inHours.toString() ?? '',
              })),
        ),

        // if the ad is loaded, show the ad
        if (_isAdLoaded)
          SimpleDialogOption(
            child: Text(context.tr('ads.caption')),
          ),

        if (hasReachedLimit)
          SimpleDialogOption(
            child: RewardAd(
              onUserEarnedReward: () {
                Navigator.of(context).pop();
                widget.onUserEarnedImageQuota?.call();
              },
              onAdLoaded: () {
                // show the ads caption when the ad is loaded
                setState(() {
                  _isAdLoaded = true;
                });
              },
            ),
          ),
      ],
    );
  }
}
