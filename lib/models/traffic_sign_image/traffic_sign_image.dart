import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';

class TrafficSignImage {
  String? _id;
  DateTime? _deletedAt;
  final String url;
  final DateTime? createdAt;
  final Map<String, TrafficSignDescription> explanations;

  String? get id => _id;
  set id(String? value) {
    _id ??= value;
  }

  TrafficSignImage({
    id,
    required this.url,
    this.createdAt,
    this.explanations = const {},
    DateTime? deletedAt,
  })  : _deletedAt = deletedAt,
        _id = id;

  factory TrafficSignImage.fromJson(Map<String, dynamic> json) {
    return TrafficSignImage(
      id: json['id'],
      url: json['url'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      deletedAt: json['deletedAt'] != null
          ? (json['deletedAt'] as Timestamp).toDate()
          : null,
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
      'deletedAt': _deletedAt,
      'explanations': explanations.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }

  @override
  String toString() {
    return 'TrafficSignImage{id: $id, url: $url, createdAt: $createdAt, explanations: $explanations}';
  }

  void delete() {
    _deletedAt = DateTime.now();
  }

  bool isDeleted() {
    return _deletedAt != null;
  }
}
