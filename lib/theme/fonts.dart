import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
  static TextStyle getPrimary({Color? color, TextStyle? ts}) {
    return GoogleFonts.dmSerifDisplay(color: color, textStyle: ts);
  }

  static TextStyle getSecondary({Color? color, TextStyle? ts}) {
    return GoogleFonts.dmSans(color: color, textStyle: ts);
  }
}
