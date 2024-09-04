// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_questions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizQuestionsResource _$QuizQuestionsResourceFromJson(
        Map<String, dynamic> json) =>
    QuizQuestionsResource(
      type: $enumDecode(_$QuizQuestionsResourceTypeEnumMap, json['type']),
      url: json['url'] as String,
    );

Map<String, dynamic> _$QuizQuestionsResourceToJson(
        QuizQuestionsResource instance) =>
    <String, dynamic>{
      'type': _$QuizQuestionsResourceTypeEnumMap[instance.type]!,
      'url': instance.url,
    };

const _$QuizQuestionsResourceTypeEnumMap = {
  QuizQuestionsResourceType.video: 'video',
  QuizQuestionsResourceType.image: 'image',
};

QuizQuestions _$QuizQuestionsFromJson(Map<String, dynamic> json) =>
    QuizQuestions(
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctOptions: (json['correct_options'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      score: (json['score'] as num).toInt(),
      subQuestion: json['sub_question'] as String?,
      resource: json['resource'] == null
          ? null
          : QuizQuestionsResource.fromJson(
              json['resource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizQuestionsToJson(QuizQuestions instance) =>
    <String, dynamic>{
      'question': instance.question,
      'sub_question': instance.subQuestion,
      'resource': instance.resource,
      'options': instance.options,
      'correct_options': instance.correctOptions,
      'score': instance.score,
    };
