import 'package:shared_preferences/shared_preferences.dart';

class VideoPlayCounterService {
  final SharedPreferencesAsync pref = SharedPreferencesAsync();

  Future<int> getPlayCount(String key) async {
    return (await pref.getInt('video_play_count.$key')) ?? 5;
  }

  Future<void> setPlayCount(String key, int value) async {
    await pref.setInt('video_play_count.$key', value);
  }

  Future<void> reset() async {
    var keys = await pref.getKeys();
    keys
        .where((key) => key.startsWith('video_play_count'))
        .forEach((key) async {
      await pref.remove(key);
    });
  }
}
