import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/question/question.dart';
import 'package:roadcognizer/components/question_nav_button/question_nav_buttons.dart';
import 'package:roadcognizer/models/quiz_questions.dart';
import 'package:roadcognizer/services/questions/questions.service.dart';
import 'package:roadcognizer/theme/fonts.dart';

class QuestionsScreen extends StatefulWidget {
  final void Function(
      List<QuizQuestions> questions, List<List<int>> selectedAnswers) onSubmit;

  const QuestionsScreen({super.key, required this.onSubmit});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var activeQuestion = 0;
  List<List<int>> selectedAnswers = [];
  List<QuizQuestions> shuffledQuestions = [];

  void onTapPrevious() {
    setState(() {
      activeQuestion = max(0, activeQuestion - 1);
    });
  }

  Future<void> _loadQuestions() async {
    final autobahnQuestions = await QuestionsService.getRandom();
    setState(() {
      shuffledQuestions = autobahnQuestions;
      selectedAnswers = List.generate(
        shuffledQuestions.length,
        (_) => [],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void onTapNext() {
    setState(() {
      activeQuestion = min(shuffledQuestions.length - 1, activeQuestion + 1);
    });
  }

  Widget getQuestionWidget(QuizQuestions? curQuestion) {
    return curQuestion == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Question(
            question: curQuestion,
            selectedAnswers: selectedAnswers[activeQuestion],
            onTapAnswer: (selectedAnswerIndex) {
              setState(() {
                if (selectedAnswers[activeQuestion]
                    .contains(selectedAnswerIndex)) {
                  selectedAnswers[activeQuestion].remove(selectedAnswerIndex);
                } else {
                  selectedAnswers[activeQuestion].add(selectedAnswerIndex);
                }
              });
            });
  }

  void submit() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('question.submitDialogTitle'.tr()),
          content: Text('question.submitConfirm'.tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('question.cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                widget.onSubmit(shuffledQuestions, selectedAnswers);
              },
              child: Text('question.submit'.tr()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final curQuestion =
        shuffledQuestions.isNotEmpty ? shuffledQuestions[activeQuestion] : null;

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
                '${activeQuestion + 1}/${shuffledQuestions.length}',
                style: Fonts.getSecondary(),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepOrange.shade900,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: submit,
                icon: const Icon(Icons.arrow_forward, size: 16),
                iconAlignment: IconAlignment.end,
                label: Text(
                  'Submit',
                  style: Fonts.getSecondary(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Question
              getQuestionWidget(curQuestion),

              // Spacing
              const SizedBox(
                height: 20,
              ),

              // Navigation Buttons
              SizedBox(
                width: double.infinity,
                child: QuestionNavButtons(
                  hasPrevious: activeQuestion > 0,
                  hasNext: activeQuestion < shuffledQuestions.length - 1,
                  onTapPrevious: onTapPrevious,
                  onTapNext: onTapNext,
                  onTapSubmit: submit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
