import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';

class RoadcognizerUser {
  final String uid;
  final DateTime? createdAt;
  final DateTime? premiumUntil;
  final bool isVerified;
  List<TrafficSignImage> images;

  RoadcognizerUser({
    required this.uid,
    this.createdAt,
    this.premiumUntil,
    this.isVerified = false,
    this.images = const [],
  });

  factory RoadcognizerUser.fromJson(Map<String, dynamic> json) {
    final jsonImages = json['images'];

    final List<TrafficSignImage> listOfImages = jsonImages != null
        ? List<TrafficSignImage>.from(
            jsonImages.map(
              (model) => TrafficSignImage.fromJson(model),
            ),
          )
        : [];

    return RoadcognizerUser(
      uid: json['uid'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      premiumUntil: json['premiumUntil'] != null
          ? (json['premiumUntil'] as Timestamp).toDate()
          : null,
      images: listOfImages,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'premiumUntil': premiumUntil,
      'images': images.map((model) => model.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'RoadcognizerUser{uid: $uid,'
        'createdAt: $createdAt,'
        'premiumUntil: $premiumUntil,'
        'images: $images}';
  }

  factory RoadcognizerUser.fromFirebaseUser(User user) {
    return RoadcognizerUser(
      uid: user.uid,
      isVerified: !user.isAnonymous &&
          (user.emailVerified || user.providerData.length > 1),
    );
  }
}
