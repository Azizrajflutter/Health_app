import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData LightTheme = ThemeData(
  colorScheme: ColorScheme.light(
      secondaryContainer: const Color.fromRGBO(72, 148, 254, 1),
      brightness: Brightness.light,
      primaryContainer: Color.fromRGBO(99, 180, 255, 0.1),
      onSecondary: const Color.fromRGBO(134, 150, 187, 1),
      onPrimary: Color.fromRGBO(219, 219, 219, 1)),
  brightness: Brightness.light,
  fontFamily: GoogleFonts.urbanist().fontFamily,
  textTheme: TextTheme(
      labelSmall: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: const Color.fromRGBO(219, 219, 219, 1)),
      displayMedium: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
      displayLarge: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        // color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: const Color.fromRGBO(203, 225, 255, 1)),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
          color: const Color.fromRGBO(219, 219, 219, 1), fontSize: 12),
      headlineMedium: TextStyle(
          color: const Color.fromRGBO(219, 219, 219, 1),
          fontSize: 12.sp,
          fontFamily: GoogleFonts.poppins().fontFamily),
      bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15.sp,
          fontFamily: GoogleFonts.poppins().fontFamily,
          color: const Color.fromRGBO(134, 150, 187, 1)),
      bodyLarge: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400)),
);
