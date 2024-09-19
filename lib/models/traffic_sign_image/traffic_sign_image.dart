import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';

class TrafficSignImage {
  final String? id;
  final String url;
  final DateTime? createdAt;
  final Map<String, TrafficSignDescription> explanations;

  TrafficSignImage({
    this.id,
    required this.url,
    this.createdAt,
    this.explanations = const {},
  });

  factory TrafficSignImage.fromJson(Map<String, dynamic> json) {
    return TrafficSignImage(
      id: json['id'],
      url: json['url'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      explanations: Map<String, TrafficSignDescription>.from(
        json['explanations'].map(
          (key, value) => MapEntry(key, TrafficSignDescription.fromJson(value)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'explanations': explanations.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }

  @override
  String toString() {
    return 'TrafficSignImage{id: $id, url: $url, createdAt: $createdAt, explanations: $explanations}';
  }
}
