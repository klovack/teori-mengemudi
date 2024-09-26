import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:roadcognizer/services/admob/admob.service.dart';
import 'package:roadcognizer/services/log/log.dart';

class RewardAd extends StatefulWidget {
  final Function? onUserEarnedReward;
  final Function? onAdLoaded;

  const RewardAd({super.key, this.onUserEarnedReward, this.onAdLoaded});

  @override
  State<RewardAd> createState() => _RewardAdState();
}

class _RewardAdState extends State<RewardAd> {
  RewardedAd? _rewardedAd;

  @override
  void initState() {
    super.initState();

    _createRewardedAd();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdmobService.rewardedAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            log.d('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            setState(() {
              _rewardedAd = ad;
            });

            widget.onAdLoaded?.call();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            log.e('RewardedAd failed to load: $error');
            setState(() {
              _rewardedAd = null;
            });
            _createRewardedAd();
          },
        ));
  }

  void _showRewardedAd() {
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        log.i('$ad onAdShowedFullScreenContent.');
      },
      onAdDismissedFullScreenContent: (ad) {
        log.i('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log.e('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.show(onUserEarnedReward: (ad, reward) {
      log.i('$ad onUserEarnedReward: ${reward.amount}');
      widget.onUserEarnedReward?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _rewardedAd == null
        ? const SizedBox()
        : ElevatedButton(
            onPressed: _showRewardedAd,
            child: Text(context.tr('ads.cta')),
          );
  }
}
