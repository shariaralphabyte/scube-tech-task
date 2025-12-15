import 'package:flutter/material.dart';
import 'dart:io';

class CustomImageView extends StatelessWidget {
  const CustomImageView({
    Key? key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.margin,
    this.border,
    this.borderRadius,
  }) : super(key: key);

  final String? imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildImageWidget(),
          )
        : _buildImageWidget();
  }

  Widget _buildImageWidget() {
    if (imagePath == null || imagePath!.isEmpty) {
      return SizedBox(
        height: height,
        width: width,
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: _buildImageWithBorder(),
      ),
    );
  }

  Widget _buildImageWithBorder() {
    if (borderRadius != null || border != null) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Container(
          decoration: BoxDecoration(
            border: border,
            borderRadius: borderRadius,
          ),
          child: _buildImage(),
        ),
      );
    }
    return _buildImage();
  }

  Widget _buildImage() {
    if (imagePath!.startsWith('http') || imagePath!.startsWith('https')) {
      return Image.network(
        imagePath!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _errorWidget();
        },
      );
    } else if (imagePath!.startsWith('/')) {
      return Image.file(
        File(imagePath!),
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _errorWidget();
        },
      );
    } else {
      return Image.asset(
        imagePath!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _errorWidget();
        },
      );
    }
  }

  Widget _errorWidget() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          color: Colors.grey,
        ),
      ),
    );
  }
}
