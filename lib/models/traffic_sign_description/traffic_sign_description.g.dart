// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'traffic_sign_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrafficSignDetail _$TrafficSignDetailFromJson(Map<String, dynamic> json) =>
    TrafficSignDetail(
      signName: json['signName'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$TrafficSignDetailToJson(TrafficSignDetail instance) =>
    <String, dynamic>{
      'signName': instance.signName,
      'description': instance.description,
      'category': instance.category,
    };

TrafficSignDescription _$TrafficSignDescriptionFromJson(
        Map<String, dynamic> json) =>
    TrafficSignDescription(
      title: json['title'] as String,
      explanation: json['explanation'] as String,
      origin: json['origin'] as String,
      signs: TrafficSignDescription._signsFromJson(json['signs']),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$TrafficSignDescriptionToJson(
        TrafficSignDescription instance) =>
    <String, dynamic>{
      'title': instance.title,
      'explanation': instance.explanation,
      'origin': instance.origin,
      'error': instance.error,
      'signs': instance.signs.map((e) => e.toJson()).toList(),
    };
