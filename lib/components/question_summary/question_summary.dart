import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teori_mengemudi/components/question_resource/question_resource.dart';
import 'package:teori_mengemudi/models/quiz_questions.dart';

class QuestionSummary extends StatelessWidget {
  final QuizQuestions question;
  final List<int> selectedAnswer;
  final int index;

  const QuestionSummary({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuestionResource(
            questionsResource: question.resource,
            limitVideoPlay: false,
          ),
          Text(
            '${index + 1}. ${question.question}',
            style: GoogleFonts.dmSerifDisplay(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ...question.options.asMap().entries.map((entry) {
            final option = entry.value;
            final optionIndex = entry.key;
            final isSelected = selectedAnswer.contains(optionIndex);
            final isCorrectAnswer =
                correctAnswers.any((answer) => answer == optionIndex);
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
                  Expanded(
                      child: Text(
                    option,
                    style: GoogleFonts.dmSans(),
                  )),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
