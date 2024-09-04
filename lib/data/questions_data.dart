import 'package:teori_mengemudi/data/questions/basic_theory.dart';
import 'package:teori_mengemudi/data/questions/behavior_towards_pedestrians.dart';
import 'package:teori_mengemudi/models/quiz_questions.dart';

var questions = [
  QuizQuestions(
    question:
        "Mengapa mengkonsumsi narkoba satu kali saja (seperti ganja, heroin, kokain) berbahaya?",
    subQuestion: "Karena",
    options: [
      "menyebabkan ketidakmampuan mengemudi",
      "menyebabkan sensasi tinggi yang berlangsung beberapa jam"
    ],
    correctOptions: [0, 1],
    score: 4,
  ),
  QuizQuestions(
    question: "Apa saja yang bisa mengurangi kemampuan mengemudi?",
    options: [
      "Melalui obat-obatan tertentu",
      "Melalui alkohol dan zat memabukkan lainnya",
      "Melalui kelelahan yang berlebihan"
    ],
    correctOptions: [0, 1, 2],
    score: 4,
  ),
  QuizQuestions(
    question:
        "Mengapa menyalip bisa berbahaya meski di jalan lurus dan terlihat kosong?",
    subQuestion: "Karena kecepatan lalu lintas yang datang sering kali",
    options: [
      "diperkirakan terlalu rendah",
      "diperkirakan terlalu tinggi",
    ],
    correctOptions: [
      0,
    ],
    score: 5,
  ),
  QuizQuestions(
    question:
        "Apa yang harus Anda perhatikan saat berkendara ke tempat parkir bawah tanah?",
    options: [
      "Pejalan kaki sering kali berjalan di jalan masuk",
      "Mata harus terbiasa dengan kondisi pencahayaan yang berubah terlebih dahulu",
      "Ban bisa rusak di pintu keluar dan masuk yang sempit",
    ],
    correctOptions: [0, 1, 2],
    score: 5,
  ),
  QuizQuestions(
    question: "Dimanakah anda dilarang menyalip?",
    options: [
      "Di jalur busway",
      "Di jalan-jalan yang membingungkan",
      "Di penyeberangan pejalan kaki",
    ],
    correctOptions: [2],
    score: 4,
  ),
  QuizQuestions(
    question:
        "Anda mendekati perlintasan kereta api. Lampu perlintasan mulai menyala tanda kereta akan lewat. Palang setengah tertutup. Apa yang anda lakukan?",
    options: [
      "Lanjutkan mengemudi selagi setengah pembatas masih terbuka",
      "Seberangi perlintasan kereta api bila tidak ada kereta yang terlihat",
      "Tunggu di depan perlintasan kereta api sampai lampu merah mati dan palang terbuka",
    ],
    correctOptions: [2],
    score: 5,
  ),
  QuizQuestions(
    question:
        "Dua kendaraan dari arah yang berlawanan saling mendekat dan keduanya ingin belok kanan. Bagaimana seharusnya mereka berperilaku secara normal?",
    options: [
      "Belok kanan dengan memutar ke belakang kendaraan yang berlawanan",
      "Belok kanan di depan satu sama lain",
    ],
    correctOptions: [1],
    score: 2,
  ),
  QuizQuestions(
    question: "Rambu lalu lintas ini menunjukkan bahwa ada",
    options: [
      "jalan bawah tanah",
      "jalan yang tertutup untuk lalu lintas kendaraan",
      "jalan buntu",
    ],
    correctOptions: [2],
    score: 2,
    resource: QuizQuestionsResource(
      type: QuizQuestionsResourceType.image,
      url: 'assets/images/signs/jalan_buntu.png',
    ),
  ),
  ...basicTheoryQuestions,
  ...behaviorTowardsPedestriansQuestions,
];
