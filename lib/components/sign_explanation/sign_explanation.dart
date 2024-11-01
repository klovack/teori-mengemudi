import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:roadcognizer/components/sign_explanation/individual_sign.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';
import 'package:roadcognizer/theme/fonts.dart';

class SignExplanation extends StatelessWidget {
  final TrafficSignDescription trafficSign;

  const SignExplanation(this.trafficSign, {super.key});

  @override
  Widget build(BuildContext context) {
    final hasOrigin = trafficSign.origin.isNotEmpty &&
        trafficSign.origin.toLowerCase() != 'unknown';
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trafficSign.title,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        if (hasOrigin)
          Text(
          'signRecognizer.origin'.tr(args: [trafficSign.origin]),
          style: Fonts.getSecondary(
            ts: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          trafficSign.explanation,
          style: Fonts.getSecondary(),
        ),
        const SizedBox(height: 20),
        ...trafficSign.signs.map((sign) {
          return IndividualSign(sign);
        }),
      ],
    );
  }
}
