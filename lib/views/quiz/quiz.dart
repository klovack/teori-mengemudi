import 'package:flutter/material.dart';
import 'package:roadcognizer/Views/start_screen/start_screen.dart';
import 'package:roadcognizer/models/quiz_questions.dart';
import 'package:roadcognizer/services/video_play_counter/video_play_counter.service.dart';
import 'package:roadcognizer/views/questions_screen/questions_screen.dart';
import 'package:roadcognizer/views/result_screen/result_screen.dart';

enum QuizScreenType {
  start,
  questions,
  result,
}

class QuizScreen extends StatefulWidget {
  final VideoPlayCounterService videoPlayCounterService =
      VideoPlayCounterService();

  final Function()? onQuizStart;
  final Function()? onQuizEnd;

  QuizScreen({super.key, this.onQuizStart, this.onQuizEnd});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var activeScreen = QuizScreenType.start;
  List<QuizQuestions> _questions = [];
  List<List<int>> _selectedAnswers = [];

  void _startQuiz() {
    widget.onQuizStart?.call();
    setState(() {
      activeScreen = QuizScreenType.questions;
    });
  }

  void _submitQuiz(
    List<QuizQuestions> questions,
    List<List<int>> selectedAnswers,
  ) {
    setState(() {
      _questions = questions;
      _selectedAnswers = selectedAnswers;
      activeScreen = QuizScreenType.result;
    });
  }

  void _endQuiz() {
    widget.videoPlayCounterService.reset();
    widget.onQuizEnd?.call();
    setState(() {
      activeScreen = QuizScreenType.start;
    });
  }

  Widget getActiveScreen() {
    switch (activeScreen) {
      case QuizScreenType.questions:
        return QuestionsScreen(
          onSubmit: _submitQuiz,
        );
      case QuizScreenType.result:
        return ResultScreen(
          onReset: _endQuiz,
          questions: _questions,
          selectedAnswers: _selectedAnswers,
        );
      case QuizScreenType.start:
      default:
        return StartScreen(
          onStart: _startQuiz,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getActiveScreen();
  }
}
