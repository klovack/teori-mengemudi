import 'package:json_annotation/json_annotation.dart';

part 'quiz_questions.g.dart';

@JsonEnum()
enum QuizQuestionsResourceType {
  video,
  image,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class QuizQuestionsResource {
  final QuizQuestionsResourceType type;
  final String url;

  QuizQuestionsResource({
    required this.type,
    required this.url,
  });

  factory QuizQuestionsResource.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionsResourceFromJson(json);

  Map<String, dynamic> toJson() => _$QuizQuestionsResourceToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class QuizQuestions {
  final String question;
  final String? subQuestion;
  final QuizQuestionsResource? resource;
  final List<String> options;
  final List<int> correctOptions;
  final int score;

  List<int>? _shuffledCorrectOption;
  List<String>? _shuffledOptions;

  QuizQuestions({
    required this.question,
    required this.options,
    required this.correctOptions,
    required this.score,
    this.subQuestion,
    this.resource,
  });

  bool isCorrect(List<int> selectedOptions) {
    return selectedOptions.isNotEmpty &&
        selectedOptions.every((element) => correctOptions.contains(element));
  }

  List<String> getShuffledOptions() {
    if (_shuffledOptions != null && _shuffledCorrectOption != null) {
      return _shuffledOptions!;
    }

    _shuffledOptions = List.from(options);
    _shuffledOptions!.shuffle();

    // transform the correct options according to the shuffled options
    _shuffledCorrectOption = [];
    for (final correctOptionIndex in correctOptions) {
      _shuffledCorrectOption!
          .add(_shuffledOptions!.indexOf(options[correctOptionIndex]));
    }

    return _shuffledOptions!;
  }

  void reset() {
    _shuffledOptions = null;
    _shuffledCorrectOption = null;
  }

  factory QuizQuestions.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$QuizQuestionsToJson(this);
}
