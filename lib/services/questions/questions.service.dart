import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:roadcognizer/models/quiz_questions.dart';

enum QuestionsCategory { autobahn, regulatoryTrafficSigns }

class QuestionsCategoryFiles {
  static const Map<QuestionsCategory, String> jsonFiles = {
    QuestionsCategory.autobahn: 'assets/questions/hazard_theory/autobahn.json',
    QuestionsCategory.regulatoryTrafficSigns:
        'assets/questions/traffic_signs/regulatory.json',
  };
}

extension QuestionsCategoryExtension on QuestionsCategory {
  String get jsonFileName {
    final jsonFile = QuestionsCategoryFiles.jsonFiles[this];
    if (jsonFile == null) {
      throw Exception('Json file not found for $this');
    }

    return jsonFile;
  }
}

class QuestionsService {
  static Future<List<QuizQuestions>> getByCategory(
      QuestionsCategory category) async {
    final String fileName = category.jsonFileName;

    final String response = await rootBundle.loadString(fileName);
    final data = await json.decode(response);
    return List<QuizQuestions>.from(
        data.map((model) => QuizQuestions.fromJson(model)));
  }

  static Future<List<QuizQuestions>> getRandom({
    int numOfQuestions = 30,
  }) async {
    const List<QuestionsCategory> categories = QuestionsCategory.values;
    final List<QuizQuestions> questions = [];

    for (final category in categories) {
      final List<QuizQuestions> categoryQuestions =
          await getByCategory(category);
      questions.addAll(categoryQuestions);
    }

    // filter questions randomly and return only the number of questions requested
    questions.shuffle();
    return questions.take(numOfQuestions).toList();
  }
}
