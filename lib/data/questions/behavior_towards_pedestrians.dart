import 'package:teori_mengemudi/models/quiz_questions.dart';

var behaviorTowardsPedestriansQuestions = [
  QuizQuestions(
    question:
        "Bagaimana perilaku yang Anda perkirakan akan terjadi pada anak-anak di penyeberangan zebra cross?",
    options: [
      "Anak-anak berlari ke penyeberangan zebra tanpa memperhatikan lalu lintas",
      "Anak-anak berbalik arah di zebra cross tanpa alasan yang jelas dan berlari kembali ke tempat semula",
      "Anak-anak selalu memperkirakan kecepatan dan jarak kendaraan yang mendekat dengan benar dan menunggu di sisi jalan",
    ],
    correctOptions: [0, 1],
    score: 5,
  ),
  QuizQuestions(
    question:
        "Apa yang dapat Anda antisipasi ketika anak-anak menunggu di lampu lalu lintas?",
    subQuestion: "Anak-anak akan...",
    options: [
      "mulai berlari ketika lampu lalu lintas di arah anda berubah dari hijau ke kuning",
      "mulai berlari bahkan ketika lampu penyebrangan masih berwarna merah karena mereka tidak sabar menunggu",
      "saling mendorong satu sama lain di jalur lalu lintas",
    ],
    correctOptions: [0, 1, 2],
    score: 4,
  ),
  QuizQuestions(
    question:
        "Jalur sepeda yang dilalui sekelompok anak-anak yang sedang bersepeda berakhir. Apa yang mungkin akan terjadi?",
    subQuestion: "Anak-anak akan...",
    options: [
      "menyeberang ke jalur lalu lintas tanpa berpikir panjang",
      "masuk terlalu tengah ke dalam jalur lalu lintas",
      "turun dan menunggu sampai semuanya lalu lintas kosong",
    ],
    correctOptions: [0, 1],
    score: 4,
  ),
  QuizQuestions(
    question: "Manakah yang benar berdasarkan gambar di atas?",
    subQuestion: "(Rem tram menyala)",
    options: [
      "Anda dapat melaju di sebelah kiri dengan kecepatan pejalan kaki jika tidak ada penumpang yang terhalang dan tidak ada risiko bahaya",
      "Jika tidak ada yang menghalangi atau membahayakan, Anda boleh melintas di sebelah kiri lebih cepat dari kecepatan pejalan kaki",
      "Penumpang harus memberi jalan kepada lalu lintas yang sedang bergerak sebelum naik ke dalam bus",
    ],
    correctOptions: [0],
    score: 4,
    resource: QuizQuestionsResource(
      type: QuizQuestionsResourceType.image,
      url: 'assets/images/traffic/tram_stop_center.png',
    ),
  ),
  QuizQuestions(
    question:
        "Apa yang harus Anda harapkan ketika lansia dengan alat bantu jalan menyeberang jalan raya?",
    options: [
      "Ia berhenti di jalur lalu lintas",
      "Ia berbalik di tengah jalan",
      "Ia menyebrang jalan secara perlahan",
    ],
    correctOptions: [0, 1, 2],
    score: 4,
  ),
];
