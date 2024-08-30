enum QuizQuestionsResourceType {
  video,
  image,
}

class QuizQuestionsResource {
  final QuizQuestionsResourceType type;
  final String url;

  QuizQuestionsResource({
    required this.type,
    required this.url,
  });
}

class QuizQuestions {
  final String question;
  final QuizQuestionsResource? resource;
  final List<String> options;
  final List<int> correctOption;
  final int score;

  List<int>? _shuffledCorrectOption;
  List<String>? _shuffledOptions;

  QuizQuestions({
    required this.question,
    required this.options,
    required this.correctOption,
    required this.score,
    this.resource,
  });

  bool isCorrect(List<int> selectedOptions) {
    return selectedOptions.isNotEmpty &&
        selectedOptions.every((element) => correctOption.contains(element));
  }

  List<String> getShuffledOptions() {
    if (_shuffledOptions != null && _shuffledCorrectOption != null) {
      return _shuffledOptions!;
    }

    _shuffledOptions = List.from(options);
    _shuffledOptions!.shuffle();

    // transform the correct options according to the shuffled options
    _shuffledCorrectOption = [];
    for (final correctOptionIndex in correctOption) {
      _shuffledCorrectOption!
          .add(_shuffledOptions!.indexOf(options[correctOptionIndex]));
    }

    return _shuffledOptions!;
  }

  void reset() {
    _shuffledOptions = null;
    _shuffledCorrectOption = null;
  }
}
