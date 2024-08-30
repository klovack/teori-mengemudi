import 'package:flutter/material.dart';

class QuestionNavButtons extends StatelessWidget {
  final bool hasPrevious;
  final bool hasNext;
  final void Function() onTapPrevious;
  final void Function() onTapNext;

  const QuestionNavButtons({
    super.key,
    required this.hasPrevious,
    required this.hasNext,
    required this.onTapPrevious,
    required this.onTapNext,
  });

  List<Widget> _navButtons() {
    List<Widget> navButtonResult = [];

    if (hasPrevious) {
      navButtonResult.add(
        IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: onTapPrevious,
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
      );
    } else {
      navButtonResult.add(const SizedBox(width: 10));
    }

    // In case we have more questions, this logic will have to change
    if (hasNext) {
      navButtonResult.add(
        IconButton(
          icon: const Icon(Icons.chevron_right_rounded),
          onPressed: onTapNext,
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
      );
    } else {
      navButtonResult.add(
        ElevatedButton(
          onPressed: () {},
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
          child: const Text("Submit"),
        ),
      );
    }

    return navButtonResult;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _navButtons(),
    );
  }
}
