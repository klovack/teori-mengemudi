import 'package:flutter/material.dart';
import 'package:teori_mengemudi/Views/start_screen/start_screen.dart';
import 'package:teori_mengemudi/models/quiz_questions.dart';
import 'package:teori_mengemudi/views/questions_screen/questions_screen.dart';
import 'package:teori_mengemudi/views/result_screen/result_screen.dart';

enum QuizScreenType {
  start,
  questions,
  result,
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

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
            setState(() {
              activeScreen = QuizScreenType.questions;
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
      home: Scaffold(
        // backgroundColor: Colors.yellowAccent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.yellowAccent,
                Colors.orange.shade600,
              ],
              stops: const [0.0, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: getActiveScreen(),
        ),
      ),
    );
  }
}
