import 'package:flutter/material.dart';
import 'package:roadcognizer/components/question_summary/question_summary.dart';
import 'package:roadcognizer/models/quiz_questions.dart';
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
    final scoreText = 'Skor Anda: ${score.item1} / ${score.item2}';

    return Container(
      padding: const EdgeInsets.all(50),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            scoreText,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).height - 280,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: questions.asMap().entries.map((entry) {
                  final question = entry.value;
                  final index = entry.key;
                  return QuestionSummary(
                    key: ValueKey(index),
                    question: question,
                    selectedAnswer: selectedAnswers[index],
                    index: index,
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            label: const Text("Kembali ke Awal"),
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
    );
  }
}
