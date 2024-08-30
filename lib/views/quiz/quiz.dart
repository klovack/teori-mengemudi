import 'package:flutter/material.dart';
import 'package:teori_mengemudi/Views/start_screen/start_screen.dart';
import 'package:teori_mengemudi/views/questions_screen/questions_screen.dart';

enum QuizScreenType {
  start,
  questions,
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = QuizScreenType.start;

  void switchScreen() {
    setState(() {
      activeScreen = QuizScreenType.questions;
    });
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
          child: activeScreen == QuizScreenType.start
              ? StartScreen(onStart: switchScreen)
              : const QuestionsScreen(),
        ),
      ),
    );
  }
}
