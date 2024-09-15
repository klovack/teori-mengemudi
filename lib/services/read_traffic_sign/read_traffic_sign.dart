import 'package:cloud_functions/cloud_functions.dart';
import 'package:roadcognizer/exception/exception.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';
import 'package:roadcognizer/services/firebase/firebase.service.dart';
import 'package:roadcognizer/services/log/log.dart';

const String _readTrafficSignFunction = 'readTrafficSign';

Future<TrafficSignDescription> readTrafficSign(
  String imageUrl, {
  String languageCode = 'EN',
}) async {
  log.d('Reading traffic sign from image: $imageUrl');

  try {
    if (languageCode.length > 2) {
      languageCode = languageCode.substring(0, 2);
    }

    final response = await FirebaseService.functions
        .httpsCallable(_readTrafficSignFunction,
            options: HttpsCallableOptions(
              timeout: const Duration(seconds: 90),
            ))
        .call(
      {
        "imageUrl": imageUrl,
        "lang": languageCode.toUpperCase(),
      },
    );

    final data = response.data as Map<Object?, Object?>;
    log.d('Transforming traffic sign data');
    return TrafficSignDescription.fromJson(data.cast<String, dynamic>());
  } catch (e) {
    log.e('Error reading traffic sign: $e');
    throw ReadTrafficException('Error reading traffic sign. $e');
  }
}
