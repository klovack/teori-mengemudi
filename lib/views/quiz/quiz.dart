import 'package:flutter/material.dart';
import 'package:roadcognizer/Views/start_screen/start_screen.dart';
import 'package:roadcognizer/components/app_scaffold/app_scaffold.dart';
import 'package:roadcognizer/models/quiz_questions.dart';
import 'package:roadcognizer/services/video_play_counter/video_play_counter.service.dart';
import 'package:roadcognizer/views/questions_screen/questions_screen.dart';
import 'package:roadcognizer/views/result_screen/result_screen.dart';

enum QuizScreenType {
  start,
  questions,
  result,
}

class Quiz extends StatefulWidget {
  final VideoPlayCounterService videoPlayCounterService =
      VideoPlayCounterService();

  Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = QuizScreenType.start;
  List<QuizQuestions> questions = [];
  List<List<int>> selectedAnswers = [];

  void switchScreen() {
    setState(() {
      activeScreen = QuizScreenType.questions;
    });
  }

  Widget getActiveScreen() {
    switch (activeScreen) {
      case QuizScreenType.questions:
        return QuestionsScreen(
          onSubmit: (q, s) {
            setState(() {
              questions = q;
              selectedAnswers = s;
              activeScreen = QuizScreenType.result;
            });
          },
        );
      case QuizScreenType.result:
        return ResultScreen(
          onReset: () {
            widget.videoPlayCounterService.reset();
            setState(() {
              activeScreen = QuizScreenType.start;
            });
          },
          questions: questions,
          selectedAnswers: selectedAnswers,
        );
      case QuizScreenType.start:
      default:
        return StartScreen(onStart: switchScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teori Mengemudi',
      home: AppScaffold(
        child: getActiveScreen(),
      ),
    );
  }
}
