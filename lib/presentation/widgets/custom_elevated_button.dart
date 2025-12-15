import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.borderRadius,
    this.margin,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final double? borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.light_blue_A700,
          foregroundColor: textColor ?? AppTheme.white_A700,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10.h),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.h,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? AppTheme.white_A700,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: fontSize ?? 16.fSize,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  fontFamily: fontFamily ?? 'Inter',
                  color: textColor ?? AppTheme.white_A700,
                ),
              ),
      ),
    );
  }
}
