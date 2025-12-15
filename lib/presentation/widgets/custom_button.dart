import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/text_style_helper.dart';
import 'custom_image_view.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isPrimary;
  final IconData? icon;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppTheme.primaryBlue : AppTheme.white,
          foregroundColor: isPrimary ? AppTheme.white : AppTheme.primaryBlue,
          elevation: isPrimary ? 0 : 1,
          side: isPrimary
              ? null
              : const BorderSide(color: AppTheme.primaryBlue, width: 1.5),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(text),
                ],
              ),
      ),
    );
  }




}

class ShortcutItemWidget extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback? onTap;

  const ShortcutItemWidget({
    super.key,
    required this.title,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.white,
          border: Border.all(
            color: AppTheme.blue_gray_200,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CustomImageView(
              imagePath: iconPath,
              width: 34,
              height: 40,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyleHelper.instance.body14SemiBoldInterMenu,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
