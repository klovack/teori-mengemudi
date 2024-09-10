import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';
import 'package:roadcognizer/services/firebase/firebase.service.dart';

const String _readTrafficSignFunction = 'readTrafficSign';

Future<TrafficSignDescription> readTrafficSign(String imageUrl) async {
  final response = await FirebaseService.functions
      .httpsCallable(_readTrafficSignFunction)
      .call({
    "imageUrl": imageUrl,
  });

  final data = response.data as Map<Object?, Object?>;
  return TrafficSignDescription.fromJson(data.cast<String, dynamic>());
}
