import 'package:json_annotation/json_annotation.dart';

part 'traffic_sign_description.g.dart';

@JsonSerializable(explicitToJson: true)
class TrafficSignDetail {
  final String signName;
  final String description;

  TrafficSignDetail({
    required this.signName,
    required this.description,
  });

  factory TrafficSignDetail.fromJson(Map<String, dynamic> json) =>
      _$TrafficSignDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TrafficSignDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TrafficSignDescription {
  final String explanation;
  final String origin;
  final String? error;
  final List<TrafficSignDetail> signs;

  TrafficSignDescription({
    required this.explanation,
    required this.origin,
    required this.signs,
    this.error,
  });

  factory TrafficSignDescription.fromJson(Map<String, dynamic> json) =>
      _$TrafficSignDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$TrafficSignDescriptionToJson(this);
}