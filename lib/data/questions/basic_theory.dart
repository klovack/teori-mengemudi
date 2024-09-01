import 'package:teori_mengemudi/models/quiz_questions.dart';

var basicTheoryQuestions = [
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
      "mengurangi kecepatan agar orang yang menyalip bisa kembali ke jalur di depan dengan aman",
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
  QuizQuestions(
    question:
        "Apa dampak dari mendengarkan musik keras, terutama dengan bass yang ekstrim, di dalam mobil?",
    options: [
      "Orang tunanetra kehilangan orientasi di sekitar kendaraan tersebut",
      "Perhatian pengemudi menjadi terganggu",
      "Hal ini memudahkan penyandang tunanetra untuk mengetahui arah jalan",
    ],
    correctOption: [0, 1],
    score: 4,
  ),
  QuizQuestions(
    question: "Apa yang dapat menyebabkan bahaya saat mengemudi?",
    options: [
      "Rem kendaraan yang tidak seimbang (satu sisi rem lebih kuat dari sisi lain)",
      "Pengemudi belok terlalu cepat",
      "Lampu depan yang tidak berfungsi dengan baik",
    ],
    correctOption: [0, 1, 2],
    score: 4,
  ),
  QuizQuestions(
    question:
        "Apa yang dapat mengakibatkan kendaraan tergelincir saat menikung?",
    options: [
      "Shockbreaker rusak",
      "Tekanan ban yang tidak sesuai",
      "Muatan terlalu rendah",
    ],
    correctOption: [0, 1, 2],
    score: 4,
  ),
];
