import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:roadcognizer/models/traffic_sign_image/traffic_sign_image.dart';

class RoadcognizerUser {
  final String uid;
  final DateTime? createdAt;
  final DateTime? premiumUntil;
  final bool isVerified;
  final int extraImageQuota;
  List<TrafficSignImage> images;

  RoadcognizerUser({
    required this.uid,
    this.createdAt,
    this.premiumUntil,
    this.isVerified = false,
    this.extraImageQuota = 0,
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
      extraImageQuota: json['extraImageQuota'] ?? 0,
    );
  }

  Map<String, dynamic> toJson([bool includeImages = false]) {
    final json = {
      'uid': uid,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'premiumUntil': premiumUntil,
      'extraImageQuota': extraImageQuota,
    };

    if (includeImages) {
      json['images'] = images.map((model) => model.toJson()).toList();
    }

    return json;
  }

  @override
  String toString() {
    return 'RoadcognizerUser{uid: $uid,'
        'createdAt: $createdAt,'
        'premiumUntil: $premiumUntil,'
        'images: $images,'
        'extraImageQuota: $extraImageQuota}';
  }

  RoadcognizerUser copyWith({
    String? uid,
    DateTime? createdAt,
    DateTime? premiumUntil,
    bool? isVerified,
    int? extraImageQuota,
    List<TrafficSignImage>? images,
  }) {
    return RoadcognizerUser(
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      premiumUntil: premiumUntil ?? this.premiumUntil,
      isVerified: isVerified ?? this.isVerified,
      extraImageQuota: extraImageQuota ?? this.extraImageQuota,
      images: images ?? this.images,
    );
  }

  factory RoadcognizerUser.fromFirebaseUser(User user) {
    return RoadcognizerUser(
      uid: user.uid,
      isVerified: !user.isAnonymous &&
          (user.emailVerified || user.providerData.length > 1),
    );
  }
}
