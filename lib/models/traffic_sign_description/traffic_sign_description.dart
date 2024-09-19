import 'package:json_annotation/json_annotation.dart';

part 'traffic_sign_description.g.dart';

@JsonSerializable(explicitToJson: true)
class TrafficSignDetail {
  final String signName;
  final String description;
  final String category;

  TrafficSignDetail({
    required this.signName,
    required this.description,
    required this.category,
  });

  factory TrafficSignDetail.fromJson(Map<String, dynamic> json) =>
      _$TrafficSignDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TrafficSignDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TrafficSignDescription {
  final String title;
  final String explanation;
  final String origin;
  final String? error;

  @JsonKey(fromJson: _signsFromJson)
  final List<TrafficSignDetail> signs;

  TrafficSignDescription({
    required this.title,
    required this.explanation,
    required this.origin,
    required this.signs,
    this.error,
  });

  factory TrafficSignDescription.fromJson(Map<String, dynamic> json) =>
      _$TrafficSignDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$TrafficSignDescriptionToJson(this);

  static List<TrafficSignDetail> _signsFromJson(dynamic json) {
    return (json as List<dynamic>)
        .map((e) => TrafficSignDetail.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  String toString() {
    return 'TrafficSignDescription{title: $title, explanation: $explanation, origin: $origin, error: $error, signs: $signs}';
  }
}
