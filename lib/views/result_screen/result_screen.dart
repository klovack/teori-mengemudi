import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/question_summary/question_summary.dart';
import 'package:roadcognizer/models/quiz_questions.dart';
import 'package:roadcognizer/theme/fonts.dart';
import 'package:tuple/tuple.dart';

class ResultScreen extends StatelessWidget {
  final void Function() onReset;
  final List<QuizQuestions> questions;
  final List<List<int>> selectedAnswers;

  const ResultScreen({
    super.key,
    required this.onReset,
    required this.questions,
    required this.selectedAnswers,
  });

  Tuple2<int, int> getScores() {
    var score = 0;
    var totalScore = 0;
    for (var i = 0; i < questions.length; i++) {
      final question = questions[i];
      final selectedAnswer = selectedAnswers[i];
      if (question.isCorrect(selectedAnswer)) {
        score += question.score;
      }
      totalScore += question.score;
    }
    return Tuple2(score, totalScore);
  }

  @override
  Widget build(BuildContext context) {
    final score = getScores();
    final isPassText =
        (score.item1 - score.item2).abs() <= 10 ? 'result.pass' : 'result.fail';
    final scoreText = isPassText.tr(
      namedArgs: {
        'score': score.item1.toString(),
        'total': score.item2.toString(),
      },
    );

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(50),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              scoreText,
              textAlign: TextAlign.center,
              style: Fonts.getPrimary(
                ts: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height - 300,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 8),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: questions.length,
                itemBuilder: (_, index) {
                  final question = questions[index];
                  return QuestionSummary(
                    key: ValueKey(index),
                    question: question,
                    selectedAnswer: selectedAnswers[index],
                    index: index,
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              label: Text('result.returnHome'.tr()),
              icon: const Icon(Icons.restart_alt_rounded),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.deepOrange,
                ),
              ),
              onPressed: onReset,
            )
          ],
        ),
      ),
    );
  }
}
