 import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import './custom_image_view.dart';

class CustomEditText extends StatefulWidget {
  const CustomEditText({
    Key? key,
    this.placeholder,
    this.textStyle,
    this.hintStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.isPasswordField = false,
    this.suffixIconPath,
    this.suffixIconSize,
    this.contentPadding,
    this.margin,
    this.validator,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.onTap,
    this.readOnly = false,
    this.maxLines,
  }) : super(key: key);

  final String? placeholder;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final bool isPasswordField;
  final String? suffixIconPath;
  final double? suffixIconSize;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        obscureText: widget.isPasswordField ? _obscureText : false,
        maxLines: widget.maxLines ?? 1,
        style: widget.textStyle ?? TextStyleHelper.instance.body14RegularInter,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle:
              widget.hintStyle ?? TextStyleHelper.instance.body14RegularInter,
          filled: widget.backgroundColor != null,
          fillColor: widget.backgroundColor,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 12.h,
              ),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          errorBorder: _buildBorder(isError: true),
          focusedErrorBorder: _buildBorder(isError: true),
          suffixIcon: _buildSuffixIcon(),
        ),
      ),
    );
  }

  InputBorder _buildBorder({bool isError = false}) {
    final borderColor = isError ? AppTheme.redCustom : widget.borderColor;

    if (borderColor == null && widget.borderWidth == null) {
      return InputBorder.none;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.h),
      borderSide: BorderSide(
        color: borderColor ?? Color(0xFFb9c5d5),
        width: widget.borderWidth ?? 1.h,
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIconPath != null) {
      return Padding(
        padding: EdgeInsets.all(12.h),
        child: CustomImageView(
          imagePath: widget.suffixIconPath!,
          height: widget.suffixIconSize ?? 18.h,
          width: widget.suffixIconSize ?? 18.h,
        ),
      );
    }

    if (widget.isPasswordField) {
      return IconButton(
        onPressed: _togglePasswordVisibility,
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          size: 20.h,
          color: AppTheme.textGray,
        ),
      );
    }

    return null;
  }
}
