import 'package:flutter/material.dart';
import 'package:teori_mengemudi/theme/fonts.dart';

class AnswerButton extends StatelessWidget {
  final String text;
  final bool isChecked;
  final void Function() onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isChecked = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.deepOrange.shade900;
    final Color bgColor = Colors.deepOrange.shade900;
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: isChecked ? bgColor : Colors.transparent,
        foregroundColor: isChecked ? Colors.white : color,
        side: BorderSide(
          color: bgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Fonts.getSecondary(),
      ),
    );
  }
}
