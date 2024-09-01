import 'package:teori_mengemudi/models/quiz_questions.dart';

var basicTheoryQuestions = [
  QuizQuestions(
    question: "Apa yang bisa menyebabkan selip saat menikung?",
    options: [
      "Shockbreaker rusak",
      "Tekanan ban yang tidak sesuai",
      "Muatan terlalu rendah",
    ],
    correctOption: [0, 1],
    score: 3,
  ),
  QuizQuestions(
    question: "Apa saja yang dapat menimbulkan risiko saat mengemudi?",
    options: [
      "Belok dengan memotong jalur berlawanan",
      "Terlambat atau tidak menyalakan lampu saat gelap",
      "Menjaga jarak dengan mobil di depan",
    ],
    correctOption: [0, 1],
    score: 4,
  ),
  QuizQuestions(
    question:
        "Manakah di bawah ini yang berbahaya bagi pengendara sepeda motor?",
    options: [
      "Berkendara dengan kaca helm terbuka",
      "Berkendara di tengah hujan deras",
      "Berkendara dengan kecepatan tinggi di jalan yang berlubang",
    ],
    correctOption: [0, 1, 2],
    score: 4,
  ),
  QuizQuestions(
    question: "Apa yang seharusnya dilakukan saat di keadaan seperti ini?",
    options: [
      "mengurangi kecepatan agar orang yang menyalip bisa kembali ke jalurnya",
      "mempercepat agar orang yang menyalip kembali ke belakang",
      "menjaga kecepatan karena jarak masih cukup aman",
    ],
    correctOption: [0],
    score: 4,
    resource: QuizQuestionsResource(
      type: QuizQuestionsResourceType.video,
      url: 'assets/videos/basics/salip_tidak_jadi.mp4',
    ),
  ),
];
