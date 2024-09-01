import 'package:flutter/material.dart';
import 'package:teori_mengemudi/components/answer_button/answer_button.dart';
import 'package:teori_mengemudi/components/question_resource/question_resource.dart';
import 'package:teori_mengemudi/models/quiz_questions.dart';
import 'package:teori_mengemudi/theme/fonts.dart';

class Question extends StatelessWidget {
  final QuizQuestions question;
  final List<int> selectedAnswers;
  final void Function(int selectedAnswerIndex) onTapAnswer;

  const Question({
    super.key,
    required this.question,
    required this.selectedAnswers,
    required this.onTapAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        QuestionResource(questionsResource: question.resource),
        Text(
          question.question,
          textAlign: TextAlign.center,
          style: Fonts.getPrimary(
            ts: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        if (question.subQuestion != null)
          Text(
            question.subQuestion!,
            textAlign: TextAlign.center,
            style: Fonts.getSecondary(
              ts: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w200,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ),
        const SizedBox(
          height: 20,
        ),
        ...question.getShuffledOptions().map(
          (option) {
            final index = question.options.indexOf(option);
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              child: AnswerButton(
                text: option,
                isChecked: selectedAnswers.contains(index),
                onTap: () {
                  onTapAnswer(index);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
