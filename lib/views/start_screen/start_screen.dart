import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/theme/fonts.dart';

class StartScreen extends StatelessWidget {
  final void Function() onStart;

  const StartScreen({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 2.3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', width: 150),
          SizedBox(
            width: 150,
            child: Text(
              "Roadcognizer",
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
          Text(context.tr('ctaReadyToDrive'), style: Fonts.getSecondary()),
          const SizedBox(height: 25),
    
          // Practice Driving Theory
          SizedBox(
            width: 300,
            child: ElevatedButton(
              onPressed: onStart,
              child: Text(
                context.tr('practiceDrivingTheory'),
                style: Fonts.getSecondary(
                  ts: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
