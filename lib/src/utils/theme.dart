import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//crie o lightTheme com as cores 6D62D5 como primaria, FFFFFF como background e 343A40 como neutral e textos
ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6D62D5),
      secondary: Color(0xFFECEBFA),
      tertiary: Color(0xFFC6C3EF),
      background: Color(0xFFFFFFFF),
      surface: Color(0xCC343A40),
      surfaceVariant: Color(0xFFD4D4D8),
      onSurface: Color(0xFFFFFFFF),
    ),

    scaffoldBackgroundColor: const Color(0xFF6D62D5),

    //textButto theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF6D62D5)),
        overlayColor: MaterialStateProperty.all<Color>(
            const Color(0xFF9D8CF9)), //0xFF8576EA
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: const Color(0xFFECEBFA),
        )),
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(const Size(14, 14)),
        iconSize: MaterialStateProperty.all<double>(22),
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFFFFFFFF)),
        iconColor: MaterialStateProperty.all<Color>(const Color(0xFF6D62D5)),
        overlayColor: MaterialStateProperty.all<Color>(
            const Color(0xFFC6C3EF)), //0xFF9D8CF9
      ),
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFFFFFFF),
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: const Color(0xFFFFFFFF),
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFFFFFFF),
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xCC343A40),
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xCC343A40),
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: const Color(0xCC343A40),
      ),
    ),
  );
}

//dark them com as cores 6D62D5 como primaria
ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6D62D5),
      secondary: Color(0xFFECEBFA),
      background: Color(0xFF343A40),
      surface: Color(0xFF343A40),
      surfaceVariant: Color(0xFFD4D4D8),
      onSurface: Color(0xFFFFFFFF),
    ),

    //textButto theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFF6D62D5)),
        foregroundColor:
            MaterialStateProperty.all<Color>(const Color(0xFFECEBFA)),
        textStyle: MaterialStateProperty.all<TextStyle>(GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFECEBFA),
        )),
      ),
    ),

    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFECEBFA),
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFECEBFA),
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: const Color(0xFFECEBFA),
      ),
    ),
  );
}
