import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teori_mengemudi/components/question/question.dart';
import 'package:teori_mengemudi/components/question_nav_button/question_nav_buttons.dart';
import 'package:teori_mengemudi/data/questions_data.dart';
import 'package:teori_mengemudi/models/quiz_questions.dart';
import 'package:teori_mengemudi/theme/fonts.dart';

class QuestionsScreen extends StatefulWidget {
  final List<QuizQuestions> shuffledQuestions = List.from(questions);
  final void Function(
      List<QuizQuestions> questions, List<List<int>> selectedAnswers) onSubmit;

  QuestionsScreen({super.key, required this.onSubmit}) {
    shuffledQuestions.shuffle();
    for (var element in shuffledQuestions) {
      element.reset();
    }
  }

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var activeQuestion = 0;
  List<List<int>> selectedAnswers = List.generate(questions.length, (_) => []);

  void onTapPrevious() {
    setState(() {
      activeQuestion = max(0, activeQuestion - 1);
    });
  }

  void onTapNext() {
    setState(() {
      activeQuestion = min(questions.length - 1, activeQuestion + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final curQuestion = widget.shuffledQuestions[activeQuestion];

    return Container(
      padding: const EdgeInsets.all(50),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.15),
              ),
              child: Text(
                '$activeQuestion/${questions.length}',
                style: Fonts.getSecondary(),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Question(
                  question: curQuestion,
                  selectedAnswers: selectedAnswers[activeQuestion],
                  onTapAnswer: (selectedAnswerIndex) {
                    setState(() {
                      if (selectedAnswers[activeQuestion]
                          .contains(selectedAnswerIndex)) {
                        selectedAnswers[activeQuestion]
                            .remove(selectedAnswerIndex);
                      } else {
                        selectedAnswers[activeQuestion]
                            .add(selectedAnswerIndex);
                      }
                    });
                  }),
              const SizedBox(
                height: 20,
              ),

              // Navigation Buttons
              SizedBox(
                width: double.infinity,
                child: QuestionNavButtons(
                  hasPrevious: activeQuestion > 0,
                  hasNext: activeQuestion < questions.length - 1,
                  onTapPrevious: onTapPrevious,
                  onTapNext: onTapNext,
                  onTapSubmit: () {
                    widget.onSubmit(widget.shuffledQuestions, selectedAnswers);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
