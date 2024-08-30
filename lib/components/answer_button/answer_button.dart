import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final Color color = Colors.deepOrange.shade700;
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: isChecked ? color : Colors.transparent,
        foregroundColor: isChecked ? Colors.white : color,
        side: BorderSide(
          color: color,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.lato(),
      ),
    );
  }
}
