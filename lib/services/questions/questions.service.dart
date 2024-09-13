import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:roadcognizer/models/quiz_questions.dart';

enum QuestionsCategory {
  autobahn,
  regulatoryTrafficSigns,
  roadTrafficUsageBehavior
}

class QuestionsCategoryFiles {
  static Map<QuestionsCategory, String> getInLanguage(String language) {
    return {
      QuestionsCategory.autobahn:
          'assets/questions/hazard_theory/autobahn_$language.json',
      QuestionsCategory.regulatoryTrafficSigns:
          'assets/questions/traffic_signs/regulatory_$language.json',
      QuestionsCategory.roadTrafficUsageBehavior:
          'assets/questions/road_traffic_behavior/road_usage_$language.json',
    };
  }
}

extension QuestionsCategoryExtension on QuestionsCategory {
  String getJsonFileNameInLanguage(String language) {
    final jsonFiles = QuestionsCategoryFiles.getInLanguage(language);
    final jsonFile = jsonFiles[this];
    if (jsonFile == null) {
      throw Exception('Json file not found for $this in $language');
    }

    return jsonFile;
  }
}

class QuestionsService {
  static Future<List<QuizQuestions>> getByCategory(
    QuestionsCategory category, {
    String language = 'en',
  }) async {
    final String fileName = category.getJsonFileNameInLanguage(language);

    final String response = await rootBundle.loadString(fileName);
    final data = await json.decode(response);
    return List<QuizQuestions>.from(
        data.map((model) => QuizQuestions.fromJson(model)));
  }

  static Future<List<QuizQuestions>> getRandom({
    int numOfQuestions = 30,
    String language = 'en',
  }) async {
    const List<QuestionsCategory> categories = QuestionsCategory.values;
    final List<QuizQuestions> questions = [];

    for (final category in categories) {
      final List<QuizQuestions> categoryQuestions =
          await getByCategory(category, language: language.toLowerCase());
      questions.addAll(categoryQuestions);
    }

    // filter questions randomly and return only the number of questions requested
    questions.shuffle();
    return questions.take(numOfQuestions).toList();
  }
}
