import 'dart:io';

class AdmobService {
  static String get rewardedAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/5224354917'
        : 'ca-app-pub-3940256099942544/1712485313';
  }
}