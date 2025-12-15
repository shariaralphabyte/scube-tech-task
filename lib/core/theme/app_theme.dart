import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color lightBlue = Color(0xFFE3F2FD);
  static const Color veryLightBlue = Color(0xFFF0F7FF);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF212121);
  static const Color textGray = Color(0xFF757575);
  static const Color textLight = Color(0xFF9E9E9E);
  static const Color orange = Color(0xFFFF9800);
  static const Color purple = Color(0xFF9C27B0);
  static const Color lightCyan = Color(0xFF00BCD4);
  static const Color green = Color(0xFF4CAF50);
  static const Color red = Color(0xFFF44336);
  static const Color divider = Color(0xFFE0E0E0);

  // Additional colors for new design
  static const Color light_blue_A700 = Color(0xFF00B0FF);
  static const Color white_A700 = Color(0xFFFFFFFF);
  static const Color blue_gray_200 = Color(0xFFDAE5F2);
  static const Color blue_gray_300 = Color(0xFFBCDCEA);
  static const Color blue_gray_300_01 = Color(0xFF90A4AE);
  static const Color redCustom = Color(0xFFF44336);
  static const Color red_700 = Color(0xFFD32F2F);
  static const Color gray_900 = Color(0xFF212121);
  static const Color color8B002F = Color(0xFF8B002F);
  static const Color circuleColor = Color(0xFF388FC9);

  // Text Styles
  static TextStyle get appBarTitle => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textDark,
      );
  
  static TextStyle get screenTitle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textDark,
      );
  
  static TextStyle get bodyText => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textDark,
      );
  
  static TextStyle get bodyTextGray => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textGray,
      );
  
  static TextStyle get dataValue => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: textDark,
      );
  
  static TextStyle get largeValue => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: textDark,
      );
  
  static TextStyle get smallText => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textGray,
      );
  
  static TextStyle get buttonText => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: white,
      );
  
  static TextStyle get tabText => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );
  
  // Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        secondary: lightBlue,
        surface: white,
        error: red,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: appBarTitle,
        iconTheme: const IconThemeData(color: textDark),
      ),
      cardTheme: CardThemeData(
        color: white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: buttonText,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: primaryBlue,
        unselectedLabelColor: textGray,
        labelStyle: tabText,
        unselectedLabelStyle: tabText,
        indicator: BoxDecoration(
          color: lightBlue,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
