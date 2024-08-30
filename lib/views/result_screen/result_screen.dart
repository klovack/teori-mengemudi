import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teori_mengemudi/models/quiz_questions.dart';
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
                  final selectedAnswer = selectedAnswers[index];
                  final correctAnswers = question.correctOption;
                  final isCorrect = question.isCorrect(selectedAnswer);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: isCorrect
                        ? null
                        : BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.red,
                            ),
                            color: Colors.red.shade900.withOpacity(0.2),
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.question,
                          style: GoogleFonts.playfairDisplay(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...question.options.asMap().entries.map((entry) {
                          final option = entry.value;
                          final optionIndex = entry.key;
                          final isSelected =
                              selectedAnswer.contains(optionIndex);
                          final isCorrectAnswer = correctAnswers
                              .any((answer) => answer == optionIndex);
                          return Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: isCorrectAnswer
                                ? null
                                : BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: isSelected
                                          ? isCorrectAnswer
                                              ? Colors.green
                                              : Colors.red
                                          : Colors.transparent,
                                    ),
                                  ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? isCorrectAnswer
                                          ? Icons.check
                                          : Icons.close
                                      : !isCorrectAnswer
                                          ? Icons.circle_outlined
                                          : Icons.circle,
                                  color: isSelected
                                      ? isCorrectAnswer
                                          ? Colors.green
                                          : Colors.red
                                      : Colors.deepOrange,
                                ),
                                const SizedBox(width: 10),
                                Expanded(child: Text(option)),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            label: const Text("Reset"),
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
