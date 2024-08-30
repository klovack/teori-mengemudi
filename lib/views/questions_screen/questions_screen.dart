import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teori_mengemudi/components/answer_button/answer_button.dart';
import 'package:teori_mengemudi/components/question_nav_button/question_nav_buttons.dart';
import 'package:teori_mengemudi/data/questions_data.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

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
    final curQuestion = questions[activeQuestion];

    return Container(
      padding: const EdgeInsets.all(50),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            curQuestion.question,
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,  
            ),
            // textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          ...curQuestion.getShuffledOptions().map(
            (option) {
              final index = curQuestion.options.indexOf(option);
              return Container(
                width: 250,
                margin: const EdgeInsets.only(bottom: 10),
                child: AnswerButton(
                  text: option,
                  isChecked: selectedAnswers[activeQuestion].contains(index),
                  onTap: () {
                    setState(() {
                      if (selectedAnswers[activeQuestion].contains(index)) {
                        selectedAnswers[activeQuestion].remove(index);
                      } else {
                        selectedAnswers[activeQuestion].add(index);
                      }
                    });
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),

          // Navigation Buttons
          SizedBox(
              width: 300,
              child: QuestionNavButtons(
                  hasPrevious: activeQuestion > 0,
                  hasNext: activeQuestion < questions.length - 1,
                  onTapPrevious: onTapPrevious,
                  onTapNext: onTapNext)),
        ],
      ),
    );
  }
}
