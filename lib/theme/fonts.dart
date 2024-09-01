import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
  static TextStyle getPrimary({TextStyle? ts}) {
    return GoogleFonts.dmSerifDisplay(textStyle: ts);
  }

  static TextStyle getSecondary({TextStyle? ts}) {
    return GoogleFonts.dmSans(textStyle: ts);
  }
}