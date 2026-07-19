import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles{
  AppTextStyles._();

  static TextStyle headline = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static TextStyle title= GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static TextStyle subtitle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14,
  );

  static TextStyle small = GoogleFonts.poppins(
    fontSize: 12,
    color: Colors.grey,
  );
}
