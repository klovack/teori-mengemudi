import 'package:flutter/material.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';
import 'package:roadcognizer/theme/fonts.dart';

class IndividualSign extends StatelessWidget {
  final TrafficSignDetail sign;

  const IndividualSign(this.sign, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 40,
              child: Image.asset(
                  'assets/images/roadcognizer/category/${sign.category}.png',
                  errorBuilder: (_, __, ___) => Image.asset(
                      'assets/images/roadcognizer/category/fallback.png'),
                  fit: BoxFit.cover),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sign.signName,
                    style: Fonts.getPrimary(),
                  ),
                  Text(
                    sign.description,
                    style: Fonts.getSecondary(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
