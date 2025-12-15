import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/text_style_helper.dart';
import 'custom_image_view.dart';

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
