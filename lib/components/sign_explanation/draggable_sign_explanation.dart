import 'package:flutter/material.dart';
import 'package:roadcognizer/components/sign_explanation/sign_explanation.dart';
import 'package:roadcognizer/models/traffic_sign_description/traffic_sign_description.dart';

class DraggableSignExplanation extends StatelessWidget {
  const DraggableSignExplanation({
    super.key,
    required TrafficSignDescription? trafficSign,
  }) : _trafficSign = trafficSign;

  final TrafficSignDescription? _trafficSign;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.03,
      maxChildSize: 0.5,
      snap: true,
      snapSizes: const [0.03, 0.5],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SignExplanation(_trafficSign!),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
