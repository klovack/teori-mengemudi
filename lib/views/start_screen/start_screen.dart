import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:teori_mengemudi/theme/fonts.dart';

class StartScreen extends StatelessWidget {
  final void Function() onStart;

  const StartScreen({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 150),
              SizedBox(
                width: 150,
                child: Text(
                  "Teori Mengemudi",
                  textAlign: TextAlign.center,
                  style: Fonts.getPrimary(
                    ts: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                iconAlignment: IconAlignment.start,
                icon: const Icon(Icons.chevron_right_rounded),
                onPressed: onStart,
                label: const Text("Mulai"),
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
              ),
            ],
          ),
          Positioned(
            right: 15,
            top: 110,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.deepOrange.shade900,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    offset: const Offset(-1, 2),
                    color: Colors.orange.shade900.withOpacity(0.8),
                  )
                ],
              ),
              child: CountryFlag.fromLanguageCode(
                'id',
                width: 35,
                shape: const Circle(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
