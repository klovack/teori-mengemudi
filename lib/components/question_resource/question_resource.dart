import 'package:flutter/material.dart';
import 'package:teori_mengemudi/components/resource_video/resource_video.dart';
import 'package:teori_mengemudi/models/quiz_questions.dart';
import 'package:video_player/video_player.dart';

class QuestionResource extends StatelessWidget {
  final QuizQuestionsResource? questionsResource;

  const QuestionResource({super.key, required this.questionsResource});

  Widget getResource() {
    if (questionsResource == null) {
      return const SizedBox();
    }

    if (questionsResource!.type == QuizQuestionsResourceType.video) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: ResourceVideo(questionsResource!.url),
        ),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Image.asset(
          questionsResource!.url,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getResource();
  }
}
