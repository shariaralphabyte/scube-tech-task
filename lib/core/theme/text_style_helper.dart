import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/size_utils.dart';
import 'app_theme.dart';

class TextStyleHelper {
  static final TextStyleHelper instance = TextStyleHelper._();
  TextStyleHelper._();

  // Headline styles
  TextStyle get headline24SemiBoldInter => GoogleFonts.inter(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w600,
        color: AppTheme.white,
      );

  TextStyle get headline24BoldInter => GoogleFonts.inter(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w700,
        color: AppTheme.textDark,
      );

  // Title styles
  TextStyle get title20SemiBoldInter => GoogleFonts.inter(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w600,
        color: AppTheme.white,
      );

  // Body styles
  TextStyle get body14RegularInter => GoogleFonts.inter(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        color: AppTheme.textDark,
      );

  TextStyle get body14MediumInter => GoogleFonts.inter(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w500,
        color: AppTheme.textDark,
      );

  TextStyle get body14SemiBoldInter => GoogleFonts.inter(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w600,
        color: AppTheme.textDark,
      );

  TextStyle get body14SemiBoldInterMenu => GoogleFonts.inter(
    fontSize: 14.fSize,
    fontWeight: FontWeight.w600,
    color: AppTheme.textGray,
  );
  TextStyle get body12MediumInter => GoogleFonts.inter(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w500,
        color: AppTheme.textDark,
      );

  TextStyle get body12RegularInter => GoogleFonts.inter(
        fontSize: 12.fSize,
        fontWeight: FontWeight.w400,
        color: AppTheme.textDark,
      );

  TextStyle get label10MediumInter => GoogleFonts.inter(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w500,
        color: AppTheme.textDark,
      );
}
